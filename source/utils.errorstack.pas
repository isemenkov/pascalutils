(******************************************************************************)
(*                                PascalUtils                                 *)
(*              object pascal library of utils data structures                *)
(*                                                                            *)
(* Copyright (c) 2020                                       Ivan Semenkov     *)
(* https://github.com/isemenkov/pascalutils                 ivan@semenkov.pro *)
(*                                                          Ukraine           *)
(******************************************************************************)
(*                                                                            *)
(* This source  is free software;  you can redistribute  it and/or modify  it *)
(* under the terms of the GNU General Public License as published by the Free *)
(* Software Foundation; either version 3 of the License.                      *)
(*                                                                            *)
(* This code is distributed in the  hope that it will  be useful, but WITHOUT *)
(* ANY  WARRANTY;  without even  the implied  warranty of MERCHANTABILITY  or *)
(* FITNESS FOR A PARTICULAR PURPOSE.  See the  GNU General Public License for *)
(* more details.                                                              *)
(*                                                                            *)
(* A copy  of the  GNU General Public License is available  on the World Wide *)
(* Web at <http://www.gnu.org/copyleft/gpl.html>. You  can also obtain  it by *)
(* writing to the Free Software Foundation, Inc., 51  Franklin Street - Fifth *)
(* Floor, Boston, MA 02110-1335, USA.                                         *)
(*                                                                            *)
(******************************************************************************)

unit utils.errorstack;

{$mode objfpc}{$H+}
{$IFOPT D+}
  {$DEFINE DEBUG}
{$ENDIF}

interface

uses
  SysUtils {$IFDEF USE_OPTIONAL}, utils.optional{$ENDIF};

type
  {$IFNDEF USE_OPTIONAL}
  { ErrorStack is empty }
  EErrorNotExists = class(Exception);
  {$ENDIF}

  { TArrayErrorStack is generic stack over array of T which contains errors 
    codes. }
  generic TArrayErrorStack<T> = class
  {$IFDEF USE_OPTIONAL}
  public
    type
      TOptionalError = specialize TOptional<T>;
  {$ENDIF}
  public
    constructor Create;
    destructor Destroy; override;

    { Push error to stack }
    procedure Push (AError : T);

    { Return top error and remove it from stack. Raise EErrorNotExists exception
      if stack is empty. }
    function Pop : {$IFNDEF USE_OPTIONAL}T{$ELSE}TOptionalError{$ENDIF};

    { Stack count elements }
    function Count : Cardinal;
  protected
    { Reallocate the array to the new size }
    function Enlarge : Boolean;
  protected
    FData : array of T;
    FLength : Cardinal;
    FAlloced : Cardinal;
  end;

  { TListErrorStack is generic stack over list of T which contains errors 
    codes. }
  generic TListErrorStack<T> = class
  {$IFDEF USE_OPTIONAL}
  public
    type
      TOptionalError = specialize TOptional<T>;
  {$ENDIF}
  protected
    { Item enty type }
    PListEntry = ^TListEntry;
    TListEntry = record
      Value : T;
      Next : PListEntry;
    end;
  public
    constructor Create;
    destructor Destroy; override;

    { Push error to stack }
    procedure Push (AError : T);

    { Return top error and remove it from stack. Raise EErrorNotExists exception
      if stack is empty. }
    function Pop : {$IFNDEF USE_OPTIONAL}T{$ELSE}TOptionalError{$ENDIF};

    { Stack count elements }
    function Count : Cardinal;
  protected
    FFirstNode : PListEntry;
    FLength : Cardinal;
  end;

implementation

{ TArrayErrorStack }

constructor TArrayErrorStack.Create;
begin
  SetLength(FData, 16);
  FAlloced := 16;
  FLength := 0;
end;

destructor TArrayErrorStack.Destroy;
begin
  SetLength(FData, 0);
  inherited Destroy;
end;

function TArrayErrorStack.Enlarge : Boolean;
var
  NewSize : Cardinal;
begin
  { Double the allocated size }
  NewSize := FAlloced * 2;

  { Reallocate the array to the new size }
  SetLength(FData, NewSize);
  FAlloced := NewSize;
  
  Result := True;  
end;

procedure TArrayErrorStack.Push (AError : T);
begin
  if FLength + 1 > FAlloced then
  begin
    if not Enlarge then
    begin
      Exit;
    end;
  end;

  FData[FLength] := AError;
  Inc(FLength);
end;

function TArrayErrorStack.Pop : {$IFNDEF USE_OPTIONAL}T{$ELSE}TOptionalError
  {$ENDIF};
begin
  if FLength = 0 then
  begin
    {$IFNDEF USE_OPTIONAL}
    raise EErrorNotExists.Create('Errors not exists.');
    {$ELSE}
    Exit(TOptionalError.Create);
    {$ENDIF}
  end;

  Result := FData[FLength];
  Dec(FLength);
end;

function TArrayErrorStack.Count : Cardinal;
begin
  Result := FLength;
end;

{ TListErrorStack }

constructor TListErrorStack.Create;
begin
  FFirstNode := nil;
  FLength := 0;
end;

destructor TListErrorStack.Destroy;
var
  NextNode : PListEntry;
begin
  while FFirstNode <> nil then
  begin
    NextNode := FFirstNode^.Next;
    Dispose(FFirstNode);
    FFirstNode := NextNode;
  end;
end;

procedure TListErrorStack.Push (AError : T);
var
  NewNode : PListEntry;
begin
  New(NewNode);
  NewNode^.Value := T;
  NewNode^.Next := FFirstNode;
  FFirstNode := NewNode;
  Inc(FLength);  
end;

function TListErrorStack.Pop : {$IFNDEF USE_OPTIONAL}T{$ELSE}TOptionalError
  {$ENDIF}
var
  CurrNode : PListEntry;
begin
  if FFirstNode = nil then
  begin
    {$IFNDEF USE_OPTIONAL}
    raise EErrorNotExists.Create('Errors not exists.');
    {$ELSE}
    Exit(TOptionalError.Create);
    {$ENDIF}
  end;

  Result := FFirstNode^.Value;
  CurrNode := FFirstNode;
  FFirstNode := FFirstNode^.Next;
  Dispose(CurrNode);
  Dec(FLength);
end;

function TListErrorStack.Count : Cardinal;
begin
  Result := FLength;
end;

end.
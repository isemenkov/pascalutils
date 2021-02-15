(******************************************************************************)
(*                                PascalUtils                                 *)
(*          delphi and object pascal library of utils data structures         *)
(*                                                                            *)
(* Copyright (c) 2020 - 2021                                Ivan Semenkov     *)
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

unit utils.errorsstack;

{$IFDEF FPC}
  {$mode objfpc}{$H+}
{$ENDIF}
{$IFOPT D+}
  {$DEFINE DEBUG}
{$ENDIF}

interface

uses
  SysUtils {$IFDEF USE_OPTIONAL}, utils.optional{$ENDIF}, utils.enumerate;

type
  {$IFNDEF USE_OPTIONAL}
  { ErrorStack is empty }
  EErrorNotExists = class(Exception);
  {$ENDIF}

  { TArrayErrorsStack is generic stack over array of T which contains errors 
    codes. }
  {$IFDEF FPC}generic{$ENDIF} TArrayErrorsStack<T> = class
  public
    type
      {$IFDEF USE_OPTIONAL}
      TOptionalError = {$IFDEF FPC}specialize{$ENDIF} TOptional<T>;
      {$ENDIF}
  protected
    type
      { Internal container storage data type. }
      PData = ^TData;
      TData = record
        Value : T;
      end;

      TErrorsDynArray = array of PData;
      PErrorsDynArray = ^TErrorsDynArray;
  public
    type
      { TArrayErrorsStack iterator. }
      TIterator = class; { Fix for FreePascal compiler. }
      TIterator = class({$IFDEF FPC}specialize{$ENDIF} 
        TForwardIterator<T, TIterator>)
      protected
        { Create new iterator for item entry. }
        {%H-}constructor Create (Arr : PErrorsDynArray; Len : Cardinal; Pos : 
          Integer);
      public
        { Return true if iterator has correct value }
        function HasValue : Boolean; override;

        { Retrieve the next entry. }
        function Next : TIterator; override;

        { Return True if we can move to next element. }
        function MoveNext : Boolean; override;

        { Return enumerator for in operator. }
        function GetEnumerator : TIterator; override;
      protected
        { Get item value. }
        function GetValue : {$IFNDEF USE_OPTIONAL}T{$ELSE}TOptionalError
          {$ENDIF}; override;

        { Return current item iterator and move it to next. }
        function GetCurrent : {$IFNDEF USE_OPTIONAL}T{$ELSE}TOptionalError
          {$ENDIF}; override;
      public
        { Pop TArrayErrorsStack item value. If value not exists raise 
          EErrorNotExists. }
        property Value : {$IFNDEF USE_OPTIONAL}T{$ELSE}TOptionalError{$ENDIF} 
          read GetValue;

        property Current : {$IFNDEF USE_OPTIONAL}T{$ELSE}TOptionalError{$ENDIF}
          read GetCurrent;
      protected
        FArray : PErrorsDynArray;
        FLength : LongInt;
        FPosition : LongInt;
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
    function Count : LongInt;

    { Retrive the first entry in a TArrayErrorsStack. }
    function FirstEntry : TIterator;

    { Return enumerator for in operator. }
    function GetEnumerator : TIterator;
  protected
    { Reallocate the array to the new size }
    function Enlarge : Boolean;
  protected
    FData : array of PData;
    FLength : LongInt;
    FAlloced : LongInt;
  end;

  { TListErrorsStack is generic stack over list of T which contains errors 
    codes. }
  {$IFDEF FPC}generic{$ENDIF} TListErrorsStack<T> = class
  public
    type
      {$IFDEF USE_OPTIONAL}
      TOptionalError = {$IFDEF FPC}specialize{$ENDIF} TOptional<T>;
      {$ENDIF}
  protected
    type
      { Item enty type }
      PPListEntry = ^PListEntry;
      PListEntry = ^TListEntry;
      TListEntry = record
        Value : T;
        Next : PListEntry;
      end;
  public
    type
      { TListErrorsStack iterator. }
      TIterator = class; { Fix for FreePascal compiler. }
      TIterator = class({$IFDEF FPC}specialize{$ENDIF} 
        TForwardIterator<T, TIterator>)
      protected
        { Create new iterator for list errors stack item entry. }
        {%H-}constructor Create (APFirstNode : PPListEntry; APLength : 
          PLongWord; AItem : PListEntry);
      public
        { Return true if iterator has correct value }
        function HasValue : Boolean; override;

        { Retrieve the next entry in a list. }
        function Next : TIterator; override;

        { Return True if we can move to next element. }
        function MoveNext : Boolean; override;

        { Return enumerator for in operator. }
        function GetEnumerator : TIterator; override;
      protected
        { Get item value. }
        function GetValue : {$IFNDEF USE_OPTIONAL}T{$ELSE}TOptionalError
          {$ENDIF}; override;

        { Return current item iterator and move it to next. }
        function GetCurrent : {$IFNDEF USE_OPTIONAL}T{$ELSE}TOptionalError
          {$ENDIF}; override;
      protected
        var
          { We cann't store pointer to list because generics in pascal it is
            not "real" class see: https://wiki.freepascal.org/Generics 
            
            Other Points
            ============
            1. The compiler parses a generic, but instead of generating code it 
            stores all tokens in a token buffer inside the PPU file.
            2. The compiler parses a specialization; for this it loads the token 
            buffer from the PPU file and parses that again. It replaces the 
            generic parameters (in most examples "T") by the particular given 
            type (e.g. LongInt, TObject).
              The code basically appears as if the same class had been written 
            as the generic but with T replaced by the given type. 
              Therefore in theory there should be no speed differences between a
            "normal" class and a generic one.  

            In this reason we cann't take pointer to list class inside TIterator
            class. But in some methods we need modify original list data, so we
            store pointers to list data. }
          FPFirstNode : PPListEntry;
          FPLength : PLongWord;

          FItem : PListEntry;
      public
        { Read list errors stack item value. If value not exists raise 
          EErrorNotExists. }
        property Value : {$IFNDEF USE_OPTIONAL}T{$ELSE}TOptionalError{$ENDIF} 
          read GetValue;

        property Current : {$IFNDEF USE_OPTIONAL}T{$ELSE}TOptionalError{$ENDIF}
          read GetCurrent;
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
    function Count : LongInt;

    { Retrive the first entry in a TListErrorsStack. }
    function FirstEntry : TIterator;

    { Return enumerator for in operator. }
    function GetEnumerator : TIterator;
  protected
    FFirstNode : PListEntry;
    FLength : LongInt;
  end;

implementation

{ TArrayErrorsStack.TIterator }

constructor TArrayErrorsStack{$IFNDEF FPC}<T>{$ENDIF}.TIterator.Create
  (Arr : PErrorsDynArray; Len : Cardinal; Pos : Integer);
begin
  FArray := Arr;
  FLength := Len;
  FPosition := Pos;
end;

function TArrayErrorsStack{$IFNDEF FPC}<T>{$ENDIF}.TIterator.HasValue : 
  Boolean;
begin
  if FPosition >= FLength  then
  begin
    Exit(False);
  end;  

  Result := True;
end;

function TArrayErrorsStack{$IFNDEF FPC}<T>{$ENDIF}.TIterator.Next : TIterator;
begin
  Result := TIterator.Create(FArray, FLength, FPosition + 1);
end;

function TArrayErrorsStack{$IFNDEF FPC}<T>{$ENDIF}.TIterator.MoveNext : 
  Boolean;
begin
  Result := FPosition < FLength;
end;

function TArrayErrorsStack{$IFNDEF FPC}<T>{$ENDIF}.TIterator.GetEnumerator :
  TIterator;
begin
  Result := TIterator.Create(FArray, FLength, FPosition);
end;

function TArrayErrorsStack{$IFNDEF FPC}<T>{$ENDIF}.TIterator.GetValue :
  {$IFNDEF USE_OPTIONAL}T{$ELSE}TOptionalError{$ENDIF};
begin
  if FPosition > FLength then
  begin
    {$IFNDEF USE_OPTIONAL}
    raise EErrorNotExists.Create('Error value not exists.');
    {$ELSE}
    Exit(TOptionalError.Create);
    {$ENDIF}
  end;

  Result := {$IFDEF USE_OPTIONAL}TOptionalError.Create({$ENDIF}
    FArray^[FPosition]^.Value{$IFDEF USE_OPTIONAL}){$ENDIF};
end;

function TArrayErrorsStack{$IFNDEF FPC}<T>{$ENDIF}.TIterator.GetCurrent :
  {$IFNDEF USE_OPTIONAL}T{$ELSE}TOptionalError{$ENDIF};
begin
  Result := GetValue;
  Inc(FPosition);
end;

{ TArrayErrorsStack }

constructor TArrayErrorsStack{$IFNDEF FPC}<T>{$ENDIF}.Create;
begin
  SetLength(FData, 16);
  FAlloced := 16;
  FLength := 0;
end;

destructor TArrayErrorsStack{$IFNDEF FPC}<T>{$ENDIF}.Destroy;
begin
  SetLength(FData, 0);
  inherited Destroy;
end;

function TArrayErrorsStack{$IFNDEF FPC}<T>{$ENDIF}.Enlarge : Boolean;
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

procedure TArrayErrorsStack{$IFNDEF FPC}<T>{$ENDIF}.Push (AError : T);
begin
  if FLength + 1 > FAlloced then
  begin
    if not Enlarge then
    begin
      Exit;
    end;
  end;

  FData[FLength]^.Value := AError;
  Inc(FLength);
end;

function TArrayErrorsStack{$IFNDEF FPC}<T>{$ENDIF}.Pop : 
  {$IFNDEF USE_OPTIONAL}T{$ELSE}TOptionalError{$ENDIF};
begin
  if FLength = 0 then
  begin
    {$IFNDEF USE_OPTIONAL}
    raise EErrorNotExists.Create('Errors not exists.');
    {$ELSE}
    Exit(TOptionalError.Create);
    {$ENDIF}
  end;

  Result := FData[FLength]^.Value;
  Dec(FLength);
end;

function TArrayErrorsStack{$IFNDEF FPC}<T>{$ENDIF}.Count : LongInt;
begin
  Result := FLength;
end;

function TArrayErrorsStack{$IFNDEF FPC}<T>{$ENDIF}.FirstEntry : TIterator;
begin
  Result := TIterator.Create(@FData, FLength, 0);
end;

function TArrayErrorsStack{$IFNDEF FPC}<T>{$ENDIF}.GetEnumerator : 
  TIterator;
begin
  Result := TIterator.Create(@FData, FLength, 0);
end;

{ TListErrorsStack.TIterator }

constructor TListErrorsStack{$IFNDEF FPC}<T>{$ENDIF}.TIterator.Create
  (APFirstNode : PPListEntry; APlength : PLongWord; AItem : PListEntry);
begin
  FPFirstNode := APFirstNode;
  FPLength := APLength;
  FItem := AItem;
end;

function TListErrorsStack{$IFNDEF FPC}<T>{$ENDIF}.TIterator.HasValue :
  Boolean;
begin
  Result := FItem <> nil;
end;

function TListErrorsStack{$IFNDEF FPC}<T>{$ENDIF}.TIterator.Next : TIterator;
begin
  if FItem = nil then
  begin  
    Result := TIterator.Create(FPFirstNode, FPLength, nil);
    Exit;
  end;

  Result := TIterator.Create(FPFirstNode, FPLength, FItem^.Next);
end;

function TListErrorsStack{$IFNDEF FPC}<T>{$ENDIF}.TIterator.MoveNext : Boolean;
begin
  Result := FItem <> nil;
end;

function TListErrorsStack{$IFNDEF FPC}<T>{$ENDIF}.TIterator.GetEnumerator :
  TIterator;
begin
  Result := TIterator.Create(FPFirstNode, FPLength, FItem);
end;

function TListErrorsStack{$IFNDEF FPC}<T>{$ENDIF}.TIterator.GetValue :
  {$IFNDEF USE_OPTIONAL}T{$ELSE}TOptionalError{$ENDIF};
begin
  if FItem = nil then
  begin
    {$IFNDEF USE_OPTIONAL}
    raise EErrorNotExists.Create('Error not exists.');
    {$ELSE}
    Exit(TOptionalError.Create);
    {$ENDIF}
  end;

  Result := {$IFDEF USE_OPTIONAL}TOptionalError.Create({$ENDIF}FItem^.Value
    {$IFDEF USE_OPTIONAL}){$ENDIF};
end;

function TListErrorsStack{$IFNDEF FPC}<T>{$ENDIF}.TIterator.GetCurrent :
  {$IFNDEF USE_OPTIONAL}T{$ELSE}TOptionalError{$ENDIF};
begin
  Result := GetValue;
  FItem := FItem^.Next;
end;

{ TListErrorsStack }

constructor TListErrorsStack{$IFNDEF FPC}<T>{$ENDIF}.Create;
begin
  FFirstNode := nil;
  FLength := 0;
end;

destructor TListErrorsStack{$IFNDEF FPC}<T>{$ENDIF}.Destroy;
var
  NextNode : PListEntry;
begin
  while FFirstNode <> nil do
  begin
    NextNode := FFirstNode^.Next;
    Dispose(FFirstNode);
    FFirstNode := NextNode;
  end;
end;

procedure TListErrorsStack{$IFNDEF FPC}<T>{$ENDIF}.Push (AError : T);
var
  NewNode : PListEntry;
begin
  New(NewNode);
  NewNode^.Value := AError;
  NewNode^.Next := FFirstNode;
  FFirstNode := NewNode;
  Inc(FLength);  
end;

function TListErrorsStack{$IFNDEF FPC}<T>{$ENDIF}.Pop : 
  {$IFNDEF USE_OPTIONAL}T{$ELSE}TOptionalError{$ENDIF};
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

function TListErrorsStack{$IFNDEF FPC}<T>{$ENDIF}.Count : LongInt;
begin
  Result := FLength;
end;

function TListErrorsStack{$IFNDEF FPC}<T>{$ENDIF}.FirstEntry : 
  TIterator;
begin
  Result := TIterator.Create(@FFirstNode, @FLength, FFirstNode);
end;

function TListErrorsStack{$IFNDEF FPC}<T>{$ENDIF}.GetEnumerator : 
  TIterator;
begin
  Result := FirstEntry;
end;

end.

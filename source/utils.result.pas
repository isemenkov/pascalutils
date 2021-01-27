(******************************************************************************)
(*                                PascalUtils                                 *)
(*          delphi and object pascal library of utils data structures         *)
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

unit utils.result;

{$IFDEF FPC}
  {$mode objfpc}{$H+}
{$ENDIF}
{$IFOPT D+}
  {$DEFINE DEBUG}
{$ENDIF}

interface

uses
  SysUtils;

type
  { Value not exists exception }
  TValueNotExistsException = class(Exception);  

  { Error not exists exception }
  TErrorNotExistsException = class(Exception);  

  { Contains result value or error type like in GO or Rust lang }
  {$IFDEF FPC}generic{$ENDIF} TResult<V, E> = class
  public
    { Create new result contains value }
    constructor CreateValue (AValue : V);

    { Create new result contains error }
    constructor CreateError (AError : E);

    { Destroy stored value }
    destructor Destroy; override; 

    { Return true if result contains value }
    function IsOk : Boolean;
      {$IFNDEF DEBUG}inline;{$ENDIF}

    { Return true if result contains error }
    function IsErr : Boolean;
      {$IFNDEF DEBUG}inline;{$ENDIF}

    { Return value if not exists raise TValueNotExistsException }
    function Value : V;
      {$IFNDEF DEBUG}inline;{$ENDIF}

    { Return error if not exists raise TErrorNotExistsException }
    function Error : E;
      {$IFNDEF DEBUG}inline;{$ENDIF}
  protected
    type
      PV = ^V;
      PE = ^E;

      TValue = record
        Ok : Boolean;
        case Boolean of
          True  : (Value : PV);
          False : (Error : PE);
      end;
  protected
    FValue : TValue;
  end;
  
  { Contains Ok flag or error type }
  {$IFDEF FPC}generic{$ENDIF} TVoidResult<E> = class
  public
    { Create new none result }
    constructor CreateValue;

    { Create new result contains error }
    constructor CreateError (AError : E);

    { Destroy stored value }
    destructor Destroy; override;

    { Return true if result not contains error }
    function IsOk : Boolean;
      {$IFNDEF DEBUG}inline;{$ENDIF}
    
    { Return true if result contains error }
    function IsErr : Boolean;
      {$IFNDEF DEBUG}inline;{$ENDIF}

    { Return error if not exists raise TErrorNotExistsException }
    function Error : E;
      {$IFNDEF DEBUG}inline;{$ENDIF}
  protected
    type
      PE = ^E;

      TValue = record
        Ok : Boolean;
        Error : PE;
      end;
  protected
    FValue : TValue;
  end;

implementation

{ TResult generic }

constructor TResult{$IFNDEF FPC}<V, E>{$ENDIF}.CreateValue (AValue : V);
begin
  FValue.Ok := True;
  New(FValue.Value);
  FValue.Value^ := AValue;
end;

constructor TResult{$IFNDEF FPC}<V, E>{$ENDIF}.CreateError (AError : E);
begin
  FValue.Ok := False;
  New(FValue.Error);
  FValue.Error^ := AError;
end;

destructor TResult{$IFNDEF FPC}<V, E>{$ENDIF}.Destroy;
begin
  if IsOk then
  begin
    Dispose(FValue.Value);
  end else
  begin
    Dispose(FValue.Error);
  end;

  inherited Destroy;
end;

function TResult{$IFNDEF FPC}<V, E>{$ENDIF}.IsOk : Boolean;
begin
  Result := FValue.Ok;
end;

function TResult{$IFNDEF FPC}<V, E>{$ENDIF}.IsErr : Boolean;
begin
  Result := not FValue.Ok;
end;

function TResult{$IFNDEF FPC}<V, E>{$ENDIF}.Value : V;
begin
  if IsOk then
  begin
    Result := FValue.Value^;
  end else 
  begin
    raise TValueNotExistsException.Create('Value not exists');
  end;
end;

function TResult{$IFNDEF FPC}<V, E>{$ENDIF}.Error : E;
begin
  if IsErr then
  begin
    Result := FValue.Error^;
  end else 
  begin
    raise TErrorNotExistException.Create('Error not exists');
  end;
end;

{ TVoidResult }

constructor TVoidResult{$IFNDEF FPC}<E>{$ENDIF}.CreateValue;
begin
  FValue.Ok := True;
  FValue.Error := nil;
end;

constructor TVoidResult{$IFNDEF FPC}<E>{$ENDIF}.CreateError (AError : E);
begin
  FValue.Ok := False;
  New(FValue.Error);
  FValue.Error^ := AError;
end;

destructor TVoidResult{$IFNDEF FPC}<E>{$ENDIF}.Destroy;
begin
  if not IsOk then
  begin
    Dispose(FValue.Error);
  end;

  inherited Destroy;
end;

function TVoidResult{$IFNDEF FPC}<E>{$ENDIF}.IsOk : Boolean;
begin
  Result := FValue.Ok;
end;

function TVoidResult{$IFNDEF FPC}<E>{$ENDIF}.IsErr : Boolean;
begin
  Result := not FValue.Ok;
end;

function TVoidResult{$IFNDEF FPC}<E>{$ENDIF}.Error : E;
begin
  if IsErr then
  begin
    Result := FValue.Error^;
  end else
  begin
    raise TErrorNotExistsException.Create('Error not exists');
  end;
end;

end.

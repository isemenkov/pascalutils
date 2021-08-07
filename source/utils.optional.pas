(******************************************************************************)
(*                                PascalUtils                                 *)
(*          delphi and object pascal library of utils data structures         *)
(*                                                                            *)
(* Copyright (c) 2020                                       Ivan Semenkov     *)
(* https://github.com/isemenkov/pascalutils                 ivan@semenkov.pro *)
(*                                                          Ukraine           *)
(******************************************************************************)
(*                                                                            *)
(* Permission is hereby  granted, free of  charge, to any  person obtaining a *)
(* copy of this software and associated documentation files (the "Software"), *)
(* to deal in the Software without  restriction, including without limitation *)
(* the rights  to use, copy,  modify, merge, publish, distribute, sublicense, *)
(* and/or  sell copies of  the Software,  and to permit  persons to  whom the *)
(* Software  is  furnished  to  do so, subject  to the following  conditions: *)
(*                                                                            *)
(* The above copyright notice and this permission notice shall be included in *)
(* all copies or substantial portions of the Software.                        *)
(*                                                                            *)
(* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR *)
(* IMPLIED, INCLUDING BUT NOT  LIMITED TO THE WARRANTIES  OF MERCHANTABILITY, *)
(* FITNESS FOR A  PARTICULAR PURPOSE AND  NONINFRINGEMENT. IN NO  EVENT SHALL *)
(* THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER *)
(* LIABILITY,  WHETHER IN AN ACTION OF  CONTRACT, TORT OR  OTHERWISE, ARISING *)
(* FROM,  OUT OF OR  IN  CONNECTION WITH THE  SOFTWARE OR  THE  USE  OR OTHER *)
(* DEALINGS IN THE SOFTWARE.                                                  *)
(*                                                                            *)
(******************************************************************************)

unit utils.optional;

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
  { None value exception }
  TNoneValueException = class(Exception); 

  { Optional class type which can contains some value or none, like Rust lang }
  {$IFDEF FPC}generic{$ENDIF} TOptional<T> = class
  public
    { Create new Optional with None type }
    constructor Create; overload;

    { Create new Optional with Some type }
    constructor Create (AValue : T); overload;

    { Return true if optional contains value }
    function IsSome : Boolean;
      {$IFNDEF DEBUG}inline;{$ENDIF}

    { Return true if optional contains none }
    function IsNone : Boolean;
      {$IFNDEF DEBUG}inline;{$ENDIF}

    { Return stored value or raise TNoneValueException exeption if none }
    function Unwrap : T;
      {$IFNDEF DEBUG}inline;{$ENDIF}
  protected
    type
      TValue = record
        Ok : Boolean;
        Value : T;
      end;
  protected
    FValue : TValue;
  end;

implementation

{ TOptional generic }

constructor TOptional{$IFNDEF FPC}<T>{$ENDIF}.Create;
begin
  FValue.Ok := False;
end;

constructor TOptional{$IFNDEF FPC}<T>{$ENDIF}.Create (AValue : T);
begin
  FValue.Ok := True;
  FValue.Value := AValue;
end;

function TOptional{$IFNDEF FPC}<T>{$ENDIF}.IsSome : Boolean;
begin
  Result := FValue.Ok;
end;

function TOptional{$IFNDEF FPC}<T>{$ENDIF}.IsNone : Boolean;
begin
  Result := not FValue.Ok;
end;

function TOptional{$IFNDEF FPC}<T>{$ENDIF}.Unwrap : T;
begin
  if IsSome then
  begin
    Result := FValue.Value;
  end else 
  begin
    raise TNoneValueException.Create('Value not exists');
  end;
end;

end.

(******************************************************************************)
(*                                PascalUtils                                 *)
(*          delphi and object pascal library of utils data structures         *)
(*                                                                            *)
(* Copyright (c) 2021                                       Ivan Semenkov     *)
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

unit utils.any;

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
  { Wrapper for any custom value. }
  TAnyValue = class
  end;

  { Generic for any type implementation. }
  {$IFDEF FPC}generic{$ENDIF} TAny<T> = class(TAnyValue)
  public
    constructor Create (AValue : T);
    destructor Destroy; override;
  protected
    FValue : T;
  public
    property Value : T read FValue;
  end;

  TNone = ( NONE_VALUE );
  TNoneValue = {$IFDEF FPC}specialize{$ENDIF} TAny<TNone>;

  TByteValue = {$IFDEF FPC}specialize{$ENDIF} TAny<Byte>;
  TShortIntValue = {$IFDEF FPC}specialize{$ENDIF} TAny<ShortInt>;
  TWordValue = {$IFDEF FPC}specialize{$ENDIF} TAny<Word>;
  TSmallintValue = {$IFDEF FPC}specialize{$ENDIF} TAny<Smallint>;
  TIntegerValue = {$IFDEF FPC}specialize{$ENDIF} TAny<Integer>;
  {$IFDEF FPC}
  TDWordValue = {$IFDEF FPC}specialize{$ENDIF} TAny<DWord>;
  {$ENDIF}
  TCardinalValue = {$IFDEF FPC}specialize{$ENDIF} TAny<Cardinal>;
  TLongWordValue = {$IFDEF FPC}specialize{$ENDIF} TAny<LongWord>;
  TLongIntValue = {$IFDEF FPC}specialize{$ENDIF} TAny<LongInt>;
  {$IFDEF FPC}
  TQWordValue = {$IFDEF FPC}specialize{$ENDIF} TAny<QWord>;
  {$ENDIF}
  TInt64Value = {$IFDEF FPC}specialize{$ENDIF} TAny<Int64>;
  TSingleValue = {$IFDEF FPC}specialize{$ENDIF} TAny<Single>;
  TRealValue = {$IFDEF FPC}specialize{$ENDIF} TAny<Real>;
  TDoubleValue = {$IFDEF FPC}specialize{$ENDIF} TAny<Double>;
  TExtendedValue = {$IFDEF FPC}specialize{$ENDIF} TAny<Extended>;
  TCurrencyValue = {$IFDEF FPC}specialize{$ENDIF} TAny<Currency>;
  TBooleanValue = {$IFDEF FPC}specialize{$ENDIF} TAny<Boolean>;
  TCharValue = {$IFDEF FPC}specialize{$ENDIF} TAny<Char>;
  TWideCharValue = {$IFDEF FPC}specialize{$ENDIF} TAny<WideChar>;
  TAnsiStringValue = {$IFDEF FPC}specialize{$ENDIF} TAny<AnsiString>;
  TStringValue = {$IFDEF FPC}specialize{$ENDIF} TAny<String>;
  TWideStringValue = {$IFDEF FPC}specialize{$ENDIF} TAny<WideString>;
  TPointer = {$IFDEF FPC}specialize{$ENDIF} TAny<Pointer>;

implementation

{ TAny }

constructor TAny{$IFNDEF FPC}<T>{$ENDIF}.Create(AValue : T);
begin
  inherited Create;
  FValue := AValue;
end;

destructor TAny{$IFNDEF FPC}<T>{$ENDIF}.Destroy;
begin
  inherited Destroy;
end;

end.
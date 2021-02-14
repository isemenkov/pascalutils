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

unit utils.functional;

{$IFDEF FPC}
  {$mode objfpc}{$H+}
{$ENDIF}
{$IFOPT D+}
  {$DEFINE DEBUG}
{$ENDIF}

interface

uses
  SysUtils, utils.functor, utils.enumerate 
  {$IFDEF USE_OPTIONAL}, utils.optional{$ENDIF};

type
  { Accumulate iterable object data using Functor. }
  {$IFDEF FPC}generic{$ENDIF} TAccumulate<V; Iterator
    {$IFNDEF FPC}: TForwardIterator<V, Iterator>{$ENDIF};
    Functor{$IFNDEF FPC}: constructor, TBinaryFunctor<V, V>{$ENDIF}> = class
  public
    constructor Create (AIterator : Iterator; AInitial : V);
  protected
    FValue : V;
  public
    property Value : V read FValue;
  end;

  { Map applying the given functor to each item of a given iterable object. }
  {$IFDEF FPC}generic{$ENDIF} TMap<V; Iterator 
    {$IFNDEF FPC}: TForwardIterator<V, Iterator>{$ENDIF};
    Functor{$IFNDEF FPC}: constructor, TUnaryFunctor<V, V>{$ENDIF}> = class
  public
    type
      {$IFDEF USE_OPTIONAL}
      TOptionalValue = {$IFDEF FPC}specialize{$ENDIF} TOptional<V>;
      {$ENDIF}

      TIterator = class; { Fix for FreePascal compiler. }
      TIterator = class ({$IFDEF FPC}specialize{$ENDIF} TForwardIterator<V,
        TIterator>)
      protected
        constructor Create (AIterator : Iterator; AFunctor : Functor);
      public
        { Return true if iterator has correct value. }
        function HasValue : Boolean; override;

        { Retrieve the next entry. }
        function Next : TIterator; override;

        { Return True if we can move to next element. }
        function MoveNext : Boolean; override;

        { Return enumerator for in operator. }
        function GetEnumerator : TIterator; override;
      protected
        { Get item value. }
        function GetValue : {$IFNDEF USE_OPTIONAL}V{$ELSE}TOptionalValue
          {$ENDIF}; override;

        { Return current item iterator and move it to next. }
        function GetCurrent : TIterator; reintroduce;
      public
        property Value : {$IFNDEF USE_OPTIONAL}V{$ELSE}TOptionalValue
          {$ENDIF} read GetValue;

        property Current : TIterator read GetCurrent;
      protected
        FValue : V;
        FInnerIterator : Iterator;
        FFunctor : Functor;
      end;
  public 
    constructor Create (AIterator : Iterator; AFunctor : Functor);

    { Return True if we can move to next element. }
    function MoveNext : Boolean;

    { Retrive the first entry. }
    function FirstEntry : TIterator;
      {$IFNDEF DEBUG}inline;{$ENDIF}

    { Return enumerator for in operator. }
    function GetEnumerator : TIterator;
      {$IFNDEF DEBUG}inline;{$ENDIF}
  protected
    { Return current item iterator and move it to next. }
    function GetCurrent : TIterator;
  public
    property Current : TIterator read GetCurrent;
  protected
    FBaseIterator : Iterator;
    FFunctor : Functor;
    FIterator : TIterator;
  end; 

  { Accumulate functors for default data types.
    Delphi generics do not support arithmetic operators that act on generic 
    types. }
  TAdditionByteFunctor = class
    ({$IFDEF FPC}specialize{$ENDIF} TBinaryFunctor<Byte, Byte>)
  public
    function Call (AValue1, AValue2 : Byte) : Byte; override;
  end;  

  TAdditionShortIntFunctor = class
    ({$IFDEF FPC}specialize{$ENDIF} TBinaryFunctor<ShortInt, ShortInt>)
  public
    function Call (AValue1, AValue2 : ShortInt) : ShortInt; override;
  end;  

  TAdditionWordFunctor = class
    ({$IFDEF FPC}specialize{$ENDIF} TBinaryFunctor<Word, Word>)
  public
    function Call (AValue1, AValue2 : Word) : Word; override;
  end;

  TAdditionSmallIntFunctor = class
    ({$IFDEF FPC}specialize{$ENDIF} TBinaryFunctor<SmallInt, SmallInt>)
  public
    function Call (AValue1, AValue2 : SmallInt) : SmallInt; override;
  end;

  TAdditionIntegerFunctor = class
    ({$IFDEF FPC}specialize{$ENDIF} TBinaryFunctor<Integer, Integer>)
  public
    function Call (AValue1, AValue2 : Integer) : Integer; override;
  end;

  {$IFDEF FPC}
  TAdditionDWordFunctor = class
    ({$IFDEF FPC}specialize{$ENDIF} TBinaryFunctor<DWord, DWord>)
  public
    function Call (AValue1, AValue2 : DWord) : DWord; override;
  end;
  {$ENDIF}

  TAdditionCardinalFunctor = class
    ({$IFDEF FPC}specialize{$ENDIF} TBinaryFunctor<Cardinal, Cardinal>)
  public
    function Call (AValue1, AValue2 : Cardinal) : Cardinal; override;
  end;

  TAdditionLongWordFunctor = class
    ({$IFDEF FPC}specialize{$ENDIF} TBinaryFunctor<LongWord, LongWord>)
  public
    function Call (AValue1, AValue2 : LongWord) : LongWord; override;
  end;

  TAdditionLongIntFunctor = class
    ({$IFDEF FPC}specialize{$ENDIF} TBinaryFunctor<LongInt, LongInt>)
  public
    function Call (AValue1, AValue2 : LongInt) : LongInt; override;
  end;

  {$IFDEF FPC}
  TAdditionQWordFunctor = class
    ({$IFDEF FPC}specialize{$ENDIF} TBinaryFunctor<QWord, QWord>)
  public
    function Call (AValue1, AValue2 : QWord) : QWord; override;
  end;
  {$ENDIF}

  TAdditionInt64Functor = class
    ({$IFDEF FPC}specialize{$ENDIF} TBinaryFunctor<Int64, Int64>)
  public
    function Call (AValue1, AValue2 : Int64) : Int64; override;
  end;

  TAdditionSingleFunctor = class
    ({$IFDEF FPC}specialize{$ENDIF} TBinaryFunctor<Single, Single>)
  public
    function Call (AValue1, AValue2 : Single) : Single; override;
  end;

  TAdditionRealFunctor = class
    ({$IFDEF FPC}specialize{$ENDIF} TBinaryFunctor<Real, Real>)
  public
    function Call (AValue1, AValue2 : Real) : Real; override;
  end;

  TAdditionDoubleFunctor = class
    ({$IFDEF FPC}specialize{$ENDIF} TBinaryFunctor<Double, Double>)
  public
    function Call (AValue1, AValue2 : Double) : Double; override;
  end;

  TAdditionExtendedFunctor = class
    ({$IFDEF FPC}specialize{$ENDIF} TBinaryFunctor<Extended, Extended>)
  public
    function Call (AValue1, AValue2 : Extended) : Extended; override;
  end;

  TAdditionCurrencyFunctor = class
    ({$IFDEF FPC}specialize{$ENDIF} TBinaryFunctor<Currency, Currency>)
  public
    function Call (AValue1, AValue2 : Currency) : Currency; override;
  end;

  TAdditionStringFunctor = class
    ({$IFDEF FPC}specialize{$ENDIF} TBinaryFunctor<String, String>)
  public
    function Call (AValue1, AValue2 : String) : String; override;
  end;

  TAdditionWideStringFunctor = class
    ({$IFDEF FPC}specialize{$ENDIF} TBinaryFunctor<WideString, WideString>)
  public
    function Call (AValue1, AValue2 : WideString) : WideString; override;
  end;

  TMultiplicationByteFunctor = class
    ({$IFDEF FPC}specialize{$ENDIF} TBinaryFunctor<Byte, Byte>)
  public
    function Call (AValue1, AValue2 : Byte) : Byte; override;
  end;  

  TMultiplicationShortIntFunctor = class
    ({$IFDEF FPC}specialize{$ENDIF} TBinaryFunctor<ShortInt, ShortInt>)
  public
    function Call (AValue1, AValue2 : ShortInt) : ShortInt; override;
  end;  

  TMultiplicationWordFunctor = class
    ({$IFDEF FPC}specialize{$ENDIF} TBinaryFunctor<Word, Word>)
  public
    function Call (AValue1, AValue2 : Word) : Word; override;
  end;

  TMultiplicationSmallIntFunctor = class
    ({$IFDEF FPC}specialize{$ENDIF} TBinaryFunctor<SmallInt, SmallInt>)
  public
    function Call (AValue1, AValue2 : SmallInt) : SmallInt; override;
  end;

  TMultiplicationIntegerFunctor = class
    ({$IFDEF FPC}specialize{$ENDIF} TBinaryFunctor<Integer, Integer>)
  public
    function Call (AValue1, AValue2 : Integer) : Integer; override;
  end;

  {$IFDEF FPC}
  TMultiplicationDWordFunctor = class
    ({$IFDEF FPC}specialize{$ENDIF} TBinaryFunctor<DWord, DWord>)
  public
    function Call (AValue1, AValue2 : DWord) : DWord; override;
  end;
  {$ENDIF}

  TMultiplicationCardinalFunctor = class
    ({$IFDEF FPC}specialize{$ENDIF} TBinaryFunctor<Cardinal, Cardinal>)
  public
    function Call (AValue1, AValue2 : Cardinal) : Cardinal; override;
  end;

  TMultiplicationLongWordFunctor = class
    ({$IFDEF FPC}specialize{$ENDIF} TBinaryFunctor<LongWord, LongWord>)
  public
    function Call (AValue1, AValue2 : LongWord) : LongWord; override;
  end;

  TMultiplicationLongIntFunctor = class
    ({$IFDEF FPC}specialize{$ENDIF} TBinaryFunctor<LongInt, LongInt>)
  public
    function Call (AValue1, AValue2 : LongInt) : LongInt; override;
  end;

  {$IFDEF FPC}
  TMultiplicationQWordFunctor = class
    ({$IFDEF FPC}specialize{$ENDIF} TBinaryFunctor<QWord, QWord>)
  public
    function Call (AValue1, AValue2 : QWord) : QWord; override;
  end;
  {$ENDIF}

  TMultiplicationInt64Functor = class
    ({$IFDEF FPC}specialize{$ENDIF} TBinaryFunctor<Int64, Int64>)
  public
    function Call (AValue1, AValue2 : Int64) : Int64; override;
  end;

  TMultiplicationSingleFunctor = class
    ({$IFDEF FPC}specialize{$ENDIF} TBinaryFunctor<Single, Single>)
  public
    function Call (AValue1, AValue2 : Single) : Single; override;
  end;

  TMultiplicationRealFunctor = class
    ({$IFDEF FPC}specialize{$ENDIF} TBinaryFunctor<Real, Real>)
  public
    function Call (AValue1, AValue2 : Real) : Real; override;
  end;

  TMultiplicationDoubleFunctor = class
    ({$IFDEF FPC}specialize{$ENDIF} TBinaryFunctor<Double, Double>)
  public
    function Call (AValue1, AValue2 : Double) : Double; override;
  end;

  TMultiplicationExtendedFunctor = class
    ({$IFDEF FPC}specialize{$ENDIF} TBinaryFunctor<Extended, Extended>)
  public
    function Call (AValue1, AValue2 : Extended) : Extended; override;
  end;

  TMultiplicationCurrencyFunctor = class
    ({$IFDEF FPC}specialize{$ENDIF} TBinaryFunctor<Currency, Currency>)
  public
    function Call (AValue1, AValue2 : Currency) : Currency; override;
  end;
    
implementation

{ TAccumulate }

constructor TAccumulate{$IFNDEF FPC}<V, Iterator, Functor>{$ENDIF}.Create
  (AIterator : Iterator; AInitial : V);
var
  Func : Functor;
begin
  FValue := AInitial;
  Func := Functor.Create;  

  while AIterator.MoveNext do
  begin
    FValue := Func.Call(FValue, AIterator.GetValue
      {$IFDEF USE_OPTIONAL}.Unwrap{$ENDIF});
    AIterator := AIterator.Next;
  end;

  FreeAndNil(Func);
end;

{ Accumulate functors. }

function TAdditionByteFunctor.Call (AValue1, AValue2 : Byte) : Byte;
begin
  Result := AValue1 + AValue2;
end;

function TAdditionShortIntFunctor.Call (AValue1, AValue2 : ShortInt) : ShortInt;
begin
  Result := AValue1 + AValue2;
end;

function TAdditionWordFunctor.Call (AValue1, AValue2 : Word) : Word;
begin
  Result := AValue1 + AValue2;
end;

function TAdditionSmallIntFunctor.Call (AValue1, AValue2 : SmallInt) : SmallInt;
begin
  Result := AValue1 + AValue2;
end;

function TAdditionIntegerFunctor.Call (AValue1, AValue2 : Integer) : Integer;
begin
  Result := AValue1 + AValue2;
end;

{$IFDEF FPC}
function TAdditionDWordFunctor.Call (AValue1, AValue2 : DWord) : DWord;
begin
  Result := AValue1 + AValue2;
end;
{$ENDIF}

function TAdditionCardinalFunctor.Call (AValue1, AValue2 : Cardinal) : Cardinal;
begin
  Result := AValue1 + AValue2;
end;

function TAdditionLongWordFunctor.Call (AValue1, AValue2 : LongWord) : LongWord;
begin
  Result := AValue1 + AValue2;
end;

function TAdditionLongIntFunctor.Call (AValue1, AValue2 : LongInt) : LongInt;
begin
  Result := AValue1 + AValue2;
end;

{$IFDEF FPC}
function TAdditionQWordFunctor.Call (AValue1, AValue2 : QWord) : QWord;
begin
  Result := AValue1 + AValue2;
end;
{$ENDIF}

function TAdditionInt64Functor.Call (AValue1, AValue2 : Int64) : Int64;
begin
  Result := AValue1 + AValue2;
end;

function TAdditionSingleFunctor.Call (AValue1, AValue2 : Single) : Single;
begin
  Result := AValue1 + AValue2;
end;

function TAdditionRealFunctor.Call (AValue1, AValue2 : Real) : Real;
begin
  Result := AValue1 + AValue2;
end;

function TAdditionDoubleFunctor.Call (AValue1, AValue2 : Double) : Double;
begin
  Result := AValue1 + AValue2;
end;

function TAdditionExtendedFunctor.Call (AValue1, AValue2 : Extended) : Extended;
begin
  Result := AValue1 + AValue2;
end;

function TAdditionCurrencyFunctor.Call (AValue1, AValue2 : Currency) : Currency;
begin
  Result := AValue1 + AValue2;
end;

function TAdditionStringFunctor.Call (AValue1, AValue2 : String) : String;
begin
  Result := AValue1 + AValue2;
end;

function TAdditionWideStringFunctor.Call (AValue1, AValue2 : WideString) : 
  WideString;
begin
  Result := AValue1 + AValue2;
end;

function TMultiplicationByteFunctor.Call (AValue1, AValue2 : Byte) : Byte;
begin
  Result := AValue1 * AValue2;
end;

function TMultiplicationShortIntFunctor.Call (AValue1, AValue2 : ShortInt) : 
  ShortInt;
begin
  Result := AValue1 * AValue2;
end;

function TMultiplicationWordFunctor.Call (AValue1, AValue2 : Word) : Word;
begin
  Result := AValue1 * AValue2;
end;

function TMultiplicationSmallIntFunctor.Call (AValue1, AValue2 : SmallInt) : 
  SmallInt;
begin
  Result := AValue1 * AValue2;
end;

function TMultiplicationIntegerFunctor.Call (AValue1, AValue2 : Integer) : 
  Integer;
begin
  Result := AValue1 * AValue2;
end;

{$IFDEF FPC}
function TMultiplicationDWordFunctor.Call (AValue1, AValue2 : DWord) : DWord;
begin
  Result := AValue1 * AValue2;
end;
{$ENDIF}

function TMultiplicationCardinalFunctor.Call (AValue1, AValue2 : Cardinal) : 
  Cardinal;
begin
  Result := AValue1 * AValue2;
end;

function TMultiplicationLongWordFunctor.Call (AValue1, AValue2 : LongWord) : 
  LongWord;
begin
  Result := AValue1 * AValue2;
end;

function TMultiplicationLongIntFunctor.Call (AValue1, AValue2 : LongInt) : 
  LongInt;
begin
  Result := AValue1 * AValue2;
end;

{$IFDEF FPC}
function TMultiplicationQWordFunctor.Call (AValue1, AValue2 : QWord) : QWord;
begin
  Result := AValue1 * AValue2;
end;
{$ENDIF}

function TMultiplicationInt64Functor.Call (AValue1, AValue2 : Int64) : Int64;
begin
  Result := AValue1 * AValue2;
end;

function TMultiplicationSingleFunctor.Call (AValue1, AValue2 : Single) : Single;
begin
  Result := AValue1 * AValue2;
end;

function TMultiplicationRealFunctor.Call (AValue1, AValue2 : Real) : Real;
begin
  Result := AValue1 * AValue2;
end;

function TMultiplicationDoubleFunctor.Call (AValue1, AValue2 : Double) : Double;
begin
  Result := AValue1 * AValue2;
end;

function TMultiplicationExtendedFunctor.Call (AValue1, AValue2 : Extended) : 
  Extended;
begin
  Result := AValue1 * AValue2;
end;

function TMultiplicationCurrencyFunctor.Call (AValue1, AValue2 : Currency) : 
  Currency;
begin
  Result := AValue1 * AValue2;
end;

{ TMap }

constructor TMap{$IFNDEF FPC}<V, Iterator; Functor>{$ENDIF}.TIterator.Create
  (AIterator : Iterator; AFunctor : Functor);
begin
  FInnerIterator := AIterator;
  FFunctor := AFunctor;
  if AIterator.HasValue then  
    FValue := FFunctor.Call(AIterator.GetValue
    {$IFDEF USE_OPTIONAL}.Unwrap{$ENDIF});
end;

function TMap{$IFNDEF FPC}<V, Iterator; Functor>{$ENDIF}.TIterator.HasValue :
  Boolean;
begin
  Result := FInnerIterator.HasValue;
end;

function TMap{$IFNDEF FPC}<V, Iterator; Functor>{$ENDIF}.TIterator.Next :
  TIterator;
begin
  Result := TIterator.Create(FInnerIterator.Next, FFunctor);
end;

function TMap{$IFNDEF FPC}<V, Iterator; Functor>{$ENDIF}.TIterator.MoveNext :
  Boolean;
begin
  Result := FInnerIterator.MoveNext;
end;

function TMap{$IFNDEF FPC}<V, Iterator; Functor>{$ENDIF}.TIterator.GetEnumerator
  : TIterator;
begin
  Result := TIterator.Create(FInnerIterator, FFunctor);
end;

function TMap{$IFNDEF FPC}<V, Iterator; Functor>{$ENDIF}.TIterator.GetValue :
  {$IFNDEF USE_OPTIONAL}V{$ELSE}TOptionalValue{$ENDIF};
begin
  Result := {$IFNDEF USE_OPTIONAL}FValue{$ELSE}TOptionalValue.Create(FValue)
    {$ENDIF};
end;

function TMap{$IFNDEF FPC}<V, Iterator; Functor>{$ENDIF}.TIterator.GetCurrent :
  TIterator;
begin
  Result := TIterator.Create(FInnerIterator, FFunctor);
  FInnerIterator := Iterator(FInnerIterator.Next);
  if FInnerIterator.HasValue then
    FValue := FFunctor.Call(FInnerIterator.GetValue
    {$IFDEF USE_OPTIONAL}.Unwrap{$ENDIF});
end;

{ TMap }

constructor TMap{$IFNDEF FPC}<V, Iterator; Functor>{$ENDIF}.Create
  (AIterator : Iterator; AFunctor : Functor);
begin
  FBaseIterator := AIterator;
  FFunctor := AFunctor;
  FIterator := TIterator.Create(AIterator, AFunctor);
end;

function TMap{$IFNDEF FPC}<V, Iterator; Functor>{$ENDIF}.MoveNext : Boolean;
begin
  Result := FIterator.MoveNext;
end;

function TMap{$IFNDEF FPC}<V, Iterator; Functor>{$ENDIF}.GetEnumerator :
  TIterator;
begin
  Result := FIterator;
  FIterator := FIterator.Next;
end;

function TMap{$IFNDEF FPC}<V, Iterator; Functor>{$ENDIF}.FirstEntry : 
  TIterator;
begin
  Result := TIterator.Create(FBaseIterator, FFunctor);
end;

function TMap{$IFNDEF FPC}<V, Iterator; Functor>{$ENDIF}.GetCurrent : 
  TIterator;
begin
  Result := FIterator;
end;

end.

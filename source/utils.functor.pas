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

unit utils.functor;

{$IFDEF FPC}
  {$mode objfpc}{$H+}
{$ENDIF}
{$IFOPT D+}
  {$DEFINE DEBUG}
{$ENDIF}

interface

uses    
  SysUtils, utils.pair{$IFNDEF FPC}, System.Generics.Defaults{$ENDIF};

type
  { Base unary functor }  
  {$IFDEF FPC}generic{$ENDIF} TUnaryFunctor<V, R> = class
  public
    function Call(AValue : V) : R; virtual; abstract;
  end;

  { Base binary functor }
  {$IFDEF FPC}generic{$ENDIF} TBinaryFunctor<V, R> = class
  public  
    function Call(AValue1, AValue2 : V) : R; virtual; abstract;
  end;

  { -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
                                  Compare functor                                
    
    Return a negative value if value1 should be sorted before value2, a positive 
    value if value1 should be sorted after value2, zero if value1 and value2 are 
    equal.                  
    -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= }
  {$IFDEF FPC}generic{$ENDIF} TDefaultCompareFunctor<V> =
    class({$IFDEF FPC}specialize{$ENDIF} TBinaryFunctor<V, Integer>)
  public
    function Call(AValue1, AValue2 : V) : Integer; override;
  end;

  { Functors for default types. }
  TCompareFunctorByte = 
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultCompareFunctor<Byte>);
  TCompareFunctorShortInt =
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultCompareFunctor<ShortInt>);
  TCompareFunctorWord =
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultCompareFunctor<Word>);
  TCompareFunctorSmallInt =
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultCompareFunctor<SmallInt>);
  TCompareFunctorInteger =
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultCompareFunctor<Integer>);
  {$IFDEF FPC}
  TCompareFunctorDWord =
    class(specialize TDefaultCompareFunctor<DWord>);
  {$ENDIF}
  TCompareFunctorCardinal =
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultCompareFunctor<Cardinal>);
  TCompareFunctorLongWord =
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultCompareFunctor<LongWord>);
  TCompareFunctorLongInt =
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultCompareFunctor<LongInt>);
  {$IFDEF FPC}
  TCompareFunctorQWord =
    class(specialize TDefaultCompareFunctor<QWord>);
  {$ENDIF}
  TCompareFunctorInt64 =
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultCompareFunctor<Int64>);
  TCompareFunctorSingle =
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultCompareFunctor<Single>);
  TCompareFunctorReal =
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultCompareFunctor<Real>);
  TCompareFunctorDouble =
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultCompareFunctor<Double>);
  TCompareFunctorExtended =
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultCompareFunctor<Extended>);
  TCompareFunctorCurrency =
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultCompareFunctor<Currency>);
  TCompareFunctorBoolean =
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultCompareFunctor<Boolean>);
  TCompareFunctorChar =
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultCompareFunctor<Char>);
  TCompareFunctorWideChar =
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultCompareFunctor<WideChar>);
  TCompareFunctorAnsiString =
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultCompareFunctor<AnsiString>);
  TCompareFunctorString =
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultCompareFunctor<String>);
  TCompareFunctorWideString =
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultCompareFunctor<WideString>);

  { -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
                            Unsortable Compare functor                         
    
    Functor which can use to unsortable elements.                  
    -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= }
  {$IFDEF FPC}generic{$ENDIF} TUnsortableFunctor<V> = class
    ({$IFDEF FPC}specialize{$ENDIF} TBinaryFunctor<V, Integer>)
  public
    function Call({%H-}AValue1, {%H-}AValue2 : V) : Integer; override;
  end;

  { -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
                                Less logic functor                             
                        
    Return True if AValue1 < AValue2.                       
    -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= } 
  {$IFDEF FPC}generic{$ENDIF} TDefaultLessFunctor<V> =
    class ({$IFDEF FPC}specialize{$ENDIF} TBinaryFunctor<V, Boolean>)
  public
    function Call(AValue1, AValue2 : V) : Boolean; override;
  end;

  { Functors for default types. }
  TLessFunctorByte = 
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultLessFunctor<Byte>);
  TLessFunctorShortInt =
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultLessFunctor<ShortInt>);
  TLessFunctorWord =
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultLessFunctor<Word>);
  TLessFunctorSmallInt =
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultLessFunctor<SmallInt>);
  TLessFunctorInteger =
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultLessFunctor<Integer>);
  {$IFDEF FPC}
  TLessFunctorDWord =
    class(specialize TDefaultLessFunctor<DWord>);
  {$ENDIF}
  TLessFunctorCardinal =
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultLessFunctor<Cardinal>);
  TLessFunctorLongWord =
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultLessFunctor<LongWord>);
  TLessFunctorLongInt = 
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultLessFunctor<LongInt>);
  {$IFDEF FPC}
  TLessFunctorQWord =
    class(specialize TDefaultLessFunctor<QWord>);
  {$ENDIF}
  TLessFunctorInt64 =
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultLessFunctor<Int64>);
  TLessFunctorSingle =
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultLessFunctor<Single>);
  TLessFunctorReal =
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultLessFunctor<Real>);
  TLessFunctorDouble =
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultLessFunctor<Double>);
  TLessFunctorExtended =
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultLessFunctor<Extended>);
  TLessFunctorCurrency =
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultLessFunctor<Currency>);
  TLessFunctorBoolean =
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultLessFunctor<Boolean>);
  TLessFunctorChar =
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultLessFunctor<Char>);
  TLessFunctorWideChar =
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultLessFunctor<WideChar>);
  TLessFunctorAnsiString =
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultLessFunctor<AnsiString>);
  TLessFunctorString =
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultLessFunctor<String>);
  TLessFunctorWideString =
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultLessFunctor<WideString>);

  { -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
                              Greater logic functor                             
                        
    Return True if AValue1 > AValue2.                       
    -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= } 
  {$IFDEF FPC}generic{$ENDIF} TDefaultGreaterFunctor<V> =
    class ({$IFDEF FPC}specialize{$ENDIF} TBinaryFunctor<V, Boolean>)
  public
    function Call(AValue1, AValue2 : V) : Boolean; override;
  end;

  { Functors for default types. }
  TGreaterFunctorByte =
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultGreaterFunctor<Byte>);
  TGreaterFunctorShortInt =
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultGreaterFunctor<ShortInt>);
  TGreaterFunctorWord =
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultGreaterFunctor<Word>);
  TGreaterFunctorSmallInt =
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultGreaterFunctor<SmallInt>);
  TGreaterFunctorInteger =
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultGreaterFunctor<Integer>);
  {$IFDEF FPC}
  TGreaterFunctorDWord =
    class(specialize TDefaultGreaterFunctor<DWord>);
  {$ENDIF}
  TGreaterFunctorCardinal =
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultGreaterFunctor<Cardinal>);
  TGreaterFunctorLongWord =
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultGreaterFunctor<LongWord>);
  TGreaterFunctorLongInt =
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultGreaterFunctor<LongInt>);
  {$IFDEF FPC}
  TGreaterFunctorQWord =
    class(specialize TDefaultGreaterFunctor<QWord>);
  {$ENDIF}
  TGreaterFunctorInt64 =
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultGreaterFunctor<Int64>);
  TGreaterFunctorSingle =
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultGreaterFunctor<Single>);
  TGreaterFunctorReal =
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultGreaterFunctor<Real>);
  TGreaterFunctorDouble =
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultGreaterFunctor<Double>);
  TGreaterFunctorExtended =
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultGreaterFunctor<Extended>);
  TGreaterFunctorCurrency =
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultGreaterFunctor<Currency>);
  TGreaterFunctorBoolean =
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultGreaterFunctor<Boolean>);
  TGreaterFunctorChar =
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultGreaterFunctor<Char>);
  TGreaterFunctorWideChar =
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultGreaterFunctor<WideChar>);
  TGreaterFunctorAnsiString =
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultGreaterFunctor<AnsiString>);
  TGreaterFunctorString =
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultGreaterFunctor<String>);
  TGreaterFunctorWideString =
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultGreaterFunctor<WideString>);

  { -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
                               Equal logic functor                              
                        
    Return True if AValue1 = AValue2.                       
    -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= } 
  {$IFDEF FPC}generic{$ENDIF} TDefaultEqualFunctor<V> =
    class ({$IFDEF FPC}specialize{$ENDIF} TBinaryFunctor<V, Boolean>)
  public
    function Call(AValue1, AValue2 : V) : Boolean; override;
  end;

  { Functors for default types. } 
  TEqualFunctorByte = 
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultEqualFunctor<Byte>);
  TEqualFunctorShortInt = 
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultEqualFunctor<ShortInt>);
  TEqualFunctorWord = 
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultEqualFunctor<Word>);
  TEqualFunctorSmallInt = 
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultEqualFunctor<SmallInt>);
  TEqualFunctorInteger = 
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultEqualFunctor<Integer>);
  {$IFDEF FPC}
  TEqualFunctorDWord =
    class(specialize TDefaultEqualFunctor<DWord>);
  {$ENDIF}
  TEqualFunctorCardinal = 
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultEqualFunctor<Cardinal>);
  TEqualFunctorLongWord = 
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultEqualFunctor<LongWord>);
  TEqualFunctorLongInt = 
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultEqualFunctor<LongInt>);
  {$IFDEF FPC}
  TEqualFunctorQWord =
    class(specialize TDefaultEqualFunctor<QWord>);
  {$ENDIF}
  TEqualFunctorInt64 = 
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultEqualFunctor<Int64>);
  TEqualFunctorSingle = 
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultEqualFunctor<Single>);
  TEqualFunctorReal = 
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultEqualFunctor<Real>);
  TEqualFunctorDouble = 
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultEqualFunctor<Double>);
  TEqualFunctorExtended = 
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultEqualFunctor<Extended>);
  TEqualFunctorCurrency = 
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultEqualFunctor<Currency>);
  TEqualFunctorBoolean = 
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultEqualFunctor<Boolean>);
  TEqualFunctorChar = 
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultEqualFunctor<Char>);
  TEqualFunctorWideChar = 
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultEqualFunctor<WideChar>);
  TEqualFunctorAnsiString = 
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultEqualFunctor<AnsiString>);
  TEqualFunctorString = 
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultEqualFunctor<String>);
  TEqualFunctorWideString = 
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultEqualFunctor<WideString>);
  
  { -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
                                Pair key compare functor                                
    
    Return a negative value if pair 1 key value should be sorted before pair 2 
    key value, a positive value if pair 1 key value should be sorted after 
    pair 2 key value, zero if pair 1 key value and pair 2 key value 2 are equal.                  
    -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= }
  {$IFDEF FPC}generic{$ENDIF} TDefaultPairKeyCompareFunctor<K, V> =
    class({$IFDEF FPC}specialize{$ENDIF} TBinaryFunctor
    <{$IFDEF FPC}specialize{$ENDIF} TPair<K, V>, Integer>)
  public
    function Call (AValue1, AValue2 : {$IFDEF FPC}specialize{$ENDIF} TPair<K, 
      V>) : Integer; override;
  end;

  {$IFDEF FPC}generic{$ENDIF} TPairKeyCompareFunctorByte<V> = 
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultPairKeyCompareFunctor<Byte, 
    V>);
  {$IFDEF FPC}generic{$ENDIF} TPairKeyCompareFunctorShortInt<V> = 
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultPairKeyCompareFunctor<ShortInt, 
    V>);
  {$IFDEF FPC}generic{$ENDIF} TPairKeyCompareFunctorWord<V> = 
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultPairKeyCompareFunctor<Word, 
    V>);
  {$IFDEF FPC}generic{$ENDIF} TPairKeyCompareFunctorSmallInt<V> = 
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultPairKeyCompareFunctor<SmallInt, 
    V>);
  {$IFDEF FPC}generic{$ENDIF} TPairKeyCompareFunctorInteger<V> = 
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultPairKeyCompareFunctor<Integer, 
    V>);
  {$IFDEF FPC}
  {$IFDEF FPC}generic{$ENDIF} TPairKeyCompareFunctorDWord<V> = 
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultPairKeyCompareFunctor<DWord, 
    V>);
  {$ENDIF}
  {$IFDEF FPC}generic{$ENDIF} TPairKeyCompareFunctorCardinal<V> = 
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultPairKeyCompareFunctor<Cardinal, 
    V>);
  {$IFDEF FPC}generic{$ENDIF} TPairKeyCompareFunctorLongWord<V> = 
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultPairKeyCompareFunctor<LongWord, 
    V>);
  {$IFDEF FPC}generic{$ENDIF} TPairKeyCompareFunctorLongInt<V> = 
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultPairKeyCompareFunctor<LongInt, 
    V>);
  {$IFDEF FPC}
  {$IFDEF FPC}generic{$ENDIF} TPairKeyCompareFunctorQWord<V> = 
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultPairKeyCompareFunctor<QWord, 
    V>);
  {$ENDIF}
  {$IFDEF FPC}generic{$ENDIF} TPairKeyCompareFunctorInt64<V> = 
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultPairKeyCompareFunctor<Int64, 
    V>);
  {$IFDEF FPC}generic{$ENDIF} TPairKeyCompareFunctorSingle<V> = 
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultPairKeyCompareFunctor<Single, 
    V>);
  {$IFDEF FPC}generic{$ENDIF} TPairKeyCompareFunctorReal<V> = 
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultPairKeyCompareFunctor<Real, 
    V>);
  {$IFDEF FPC}generic{$ENDIF} TPairKeyCompareFunctorDouble<V> = 
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultPairKeyCompareFunctor<Double, 
    V>);
  {$IFDEF FPC}generic{$ENDIF} TPairKeyCompareFunctorExtended<V> = 
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultPairKeyCompareFunctor<Extended, 
    V>);
  {$IFDEF FPC}generic{$ENDIF} TPairKeyCompareFunctorCurrency<V> = 
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultPairKeyCompareFunctor<Currency, 
    V>);
  {$IFDEF FPC}generic{$ENDIF} TPairKeyCompareFunctorBoolean<V> = 
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultPairKeyCompareFunctor<Boolean, 
    V>);
  {$IFDEF FPC}generic{$ENDIF} TPairKeyCompareFunctorChar<V> = 
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultPairKeyCompareFunctor<Char, 
    V>);
  {$IFDEF FPC}generic{$ENDIF} TPairKeyCompareFunctorWideChar<V> = 
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultPairKeyCompareFunctor<WideChar, 
    V>);
  {$IFDEF FPC}generic{$ENDIF} TPairKeyCompareFunctorAnsiString<V> = 
    class({$IFDEF FPC}specialize{$ENDIF} 
    TDefaultPairKeyCompareFunctor<AnsiString, V>);
  {$IFDEF FPC}generic{$ENDIF} TPairKeyCompareFunctorString<V> = 
    class({$IFDEF FPC}specialize{$ENDIF} TDefaultPairKeyCompareFunctor<String, 
    V>);
  {$IFDEF FPC}generic{$ENDIF} TPairKeyCompareFunctorWideString<V> = 
    class({$IFDEF FPC}specialize{$ENDIF} 
    TDefaultPairKeyCompareFunctor<WideString, V>);

implementation

function TDefaultCompareFunctor{$IFNDEF FPC}<V>{$ENDIF}
  .Call(AValue1, AValue2 : V) : Integer;
begin
  {$IFNDEF FPC}
    Result := TComparer<V>.Default.Compare(AValue1, AValue2);
  {$ELSE}
  if AValue1 < AValue2 then
  begin
    Result := -1;
  end else if AValue2 < AValue1 then
  begin
    Result := 1
  end else
  begin
    Result := 0;
  end;
  {$ENDIF}
end;

function TUnsortableFunctor{$IFNDEF FPC}<V>{$ENDIF}
  .Call (AValue1, AValue2 : V) : Integer;
begin
  Result := 0;
end;

function TDefaultLessFunctor{$IFNDEF FPC}<V>{$ENDIF}
  .Call(AValue1, AValue2 : V) : Boolean;
begin
  {$IFNDEF FPC}
  Result := TComparer<V>.Default.Compare(AValue1, AValue2) < 1;
  {$ELSE}
  Result := AValue1 < AValue2;
  {$ENDIF}
end;

function TDefaultGreaterFunctor{$IFNDEF FPC}<V>{$ENDIF}
  .Call(AValue1, AValue2 : V) : Boolean;
begin
  {$IFNDEF FPC}
  Result := TComparer<V>.Default.Compare(AValue1, AValue2) > 1;
  {$ELSE}
  Result := AValue1 > AValue2;
  {$ENDIF}
end;

function TDefaultEqualFunctor{$IFNDEF FPC}<V>{$ENDIF}
  .Call(AValue1, AValue2 : V) : Boolean;
begin
  {$IFNDEF FPC}
  Result := TComparer<V>.Default.Compare(AValue1, AValue2) = 0;
  {$ELSE}
  Result := AValue1 = AValue2;
  {$ENDIF}
end;

function TDefaultPairKeyCompareFunctor{$IFNDEF FPC}<K, V>{$ENDIF}
  .Call(AValue1, AValue2 : {$IFDEF FPC}specialize{$ENDIF} TPair<K, V>) : 
  Integer;
begin
  {$IFNDEF FPC}
    Result := TComparer<K>.Default.Compare(AValue1.First, AValue2.First);
  {$ELSE}
  if AValue1.First < AValue2.First then
  begin
    Result := -1;
  end else if AValue2.First < AValue1.First then
  begin
    Result := 1
  end else
  begin
    Result := 0;
  end;
  {$ENDIF}
end;

end.

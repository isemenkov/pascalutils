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

unit utils.functor;

{$mode objfpc}{$H+}
{$IFOPT D+}
  {$DEFINE DEBUG}
{$ENDIF}

interface

uses    
  SysUtils;

type
  { Base unary functor }  
  generic TUnaryFunctor<V, R> = class
  public
    function Call(AValue : V) : R; virtual; abstract;
  end;

  { Base binary functor }
  generic TBinaryFunctor<V, R> = class
  public  
    function Call(AValue1, AValue2 : V) : R; virtual; abstract;
  end;

  { -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
                                  Compare functor                                
    
    Return a negative value if value1 should be sorted before value2, a positive 
    value if value1 should be sorted after value2, zero if value1 and value2 are 
    equal.                  
    -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= }
  generic TDefaultCompareFunctor<V> = 
    class(specialize TBinaryFunctor<V, Integer>)
  public
    function Call(AValue1, AValue2 : V) : Integer; override;
  end;

  { Functors for default types. }
  TCompareFunctorByte = 
    class(specialize TDefaultCompareFunctor<Byte>);
  TCompareFunctorShortInt = 
    class(specialize TDefaultCompareFunctor<ShortInt>);
  TCompareFunctorWord = 
    class(specialize TDefaultCompareFunctor<Word>);
  TCompareFunctorSmallInt = 
    class(specialize TDefaultCompareFunctor<SmallInt>);
  TCompareFunctorInteger = 
    class(specialize TDefaultCompareFunctor<Integer>);
  TCompareFunctorDWord = 
    class(specialize TDefaultCompareFunctor<DWord>);
  TCompareFunctorCardinal = 
    class(specialize TDefaultCompareFunctor<Cardinal>);
  TCompareFunctorLongWord = 
    class(specialize TDefaultCompareFunctor<LongWord>);
  TCompareFunctorLongInt = 
    class(specialize TDefaultCompareFunctor<LongInt>);
  TCompareFunctorQWord = 
    class(specialize TDefaultCompareFunctor<QWord>);
  TCompareFunctorInt64 = 
    class(specialize TDefaultCompareFunctor<Int64>);
  TCompareFunctorSingle = 
    class(specialize TDefaultCompareFunctor<Single>);
  TCompareFunctorReal = 
    class(specialize TDefaultCompareFunctor<Real>);
  TCompareFunctorDouble = 
    class(specialize TDefaultCompareFunctor<Double>);
  TCompareFunctorExtended = 
    class(specialize TDefaultCompareFunctor<Extended>);
  TCompareFunctorCurrency = 
    class(specialize TDefaultCompareFunctor<Currency>);
  TCompareFunctorBoolean = 
    class(specialize TDefaultCompareFunctor<Boolean>);
  TCompareFunctorChar = 
    class(specialize TDefaultCompareFunctor<Char>);
  TCompareFunctorWideChar = 
    class(specialize TDefaultCompareFunctor<WideChar>);  
  TCompareFunctorString = 
    class(specialize TDefaultCompareFunctor<String>);
  TCompareFunctorWideString = 
    class(specialize TDefaultCompareFunctor<WideString>);

  { -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
                            Unsortable Compare functor                         
    
    Functor which can use to unsortable elements.                  
    -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= }
  generic TUnsortableFunctor<V> = class
    (specialize TBinaryFunctor<V, Integer>)
  public
    function Call(AValue1, AValue2 : V) : Integer; override;
  end;

  { -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
                                Less logic functor                             
                        
    Return True if AValue1 < AValue2.                       
    -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= } 
  generic TDefaultLessFunctor<V> = 
    class (specialize TBinaryFunctor<V, Boolean>)
  public
    function Call(AValue1, AValue2 : V) : Boolean; override;
  end;

  { Functors for default types. } 
  TLessFunctorByte = 
    class(specialize TDefaultLessFunctor<Byte>);
  TLessFunctorShortInt = 
    class(specialize TDefaultLessFunctor<ShortInt>);
  TLessFunctorWord = 
    class(specialize TDefaultLessFunctor<Word>);
  TLessFunctorSmallInt = 
    class(specialize TDefaultLessFunctor<SmallInt>);
  TLessFunctorInteger = 
    class(specialize TDefaultLessFunctor<Integer>);
  TLessFunctorDWord = 
    class(specialize TDefaultLessFunctor<DWord>);
  TLessFunctorCardinal = 
    class(specialize TDefaultLessFunctor<Cardinal>);
  TLessFunctorLongWord = 
    class(specialize TDefaultLessFunctor<LongWord>);
  TLessFunctorLongInt = 
    class(specialize TDefaultLessFunctor<LongInt>);
  TLessFunctorQWord = 
    class(specialize TDefaultLessFunctor<QWord>);
  TLessFunctorInt64 = 
    class(specialize TDefaultLessFunctor<Int64>);
  TLessFunctorSingle = 
    class(specialize TDefaultLessFunctor<Single>);
  TLessFunctorReal = 
    class(specialize TDefaultLessFunctor<Real>);
  TLessFunctorDouble = 
    class(specialize TDefaultLessFunctor<Double>);
  TLessFunctorExtended = 
    class(specialize TDefaultLessFunctor<Extended>);
  TLessFunctorCurrency = 
    class(specialize TDefaultLessFunctor<Currency>);
  TLessFunctorBoolean = 
    class(specialize TDefaultLessFunctor<Boolean>);
  TLessFunctorChar = 
    class(specialize TDefaultLessFunctor<Char>);
  TLessFunctorWideChar = 
    class(specialize TDefaultLessFunctor<WideChar>);  
  TLessFunctorString = 
    class(specialize TDefaultLessFunctor<String>);
  TLessFunctorWideString = 
    class(specialize TDefaultLessFunctor<WideString>);

  { -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
                              Greater logic functor                             
                        
    Return True if AValue1 > AValue2.                       
    -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= } 
  generic TDefaultGreaterFunctor<V> = 
    class (specialize TBinaryFunctor<V, Boolean>)
  public
    function Call(AValue1, AValue2 : V) : Boolean; override;
  end;

  { Functors for default types. } 
  TGreaterFunctorByte = 
    class(specialize TDefaultGreaterFunctor<Byte>);
  TGreaterFunctorShortInt = 
    class(specialize TDefaultGreaterFunctor<ShortInt>);
  TGreaterFunctorWord = 
    class(specialize TDefaultGreaterFunctor<Word>);
  TGreaterFunctorSmallInt = 
    class(specialize TDefaultGreaterFunctor<SmallInt>);
  TGreaterFunctorInteger = 
    class(specialize TDefaultGreaterFunctor<Integer>);
  TGreaterFunctorDWord = 
    class(specialize TDefaultGreaterFunctor<DWord>);
  TGreaterFunctorCardinal = 
    class(specialize TDefaultGreaterFunctor<Cardinal>);
  TGreaterFunctorLongWord = 
    class(specialize TDefaultGreaterFunctor<LongWord>);
  TGreaterFunctorLongInt = 
    class(specialize TDefaultGreaterFunctor<LongInt>);
  TGreaterFunctorQWord = 
    class(specialize TDefaultGreaterFunctor<QWord>);
  TGreaterFunctorInt64 = 
    class(specialize TDefaultGreaterFunctor<Int64>);
  TGreaterFunctorSingle = 
    class(specialize TDefaultGreaterFunctor<Single>);
  TGreaterFunctorReal = 
    class(specialize TDefaultGreaterFunctor<Real>);
  TGreaterFunctorDouble = 
    class(specialize TDefaultGreaterFunctor<Double>);
  TGreaterFunctorExtended = 
    class(specialize TDefaultGreaterFunctor<Extended>);
  TGreaterFunctorCurrency = 
    class(specialize TDefaultGreaterFunctor<Currency>);
  TGreaterFunctorBoolean = 
    class(specialize TDefaultGreaterFunctor<Boolean>);
  TGreaterFunctorChar = 
    class(specialize TDefaultGreaterFunctor<Char>);
  TGreaterFunctorWideChar = 
    class(specialize TDefaultGreaterFunctor<WideChar>);  
  TGreaterFunctorString = 
    class(specialize TDefaultGreaterFunctor<String>);
  TGreaterFunctorWideString = 
    class(specialize TDefaultGreaterFunctor<WideString>);

  { -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
                               Equal logic functor                              
                        
    Return True if AValue1 = AValue2.                       
    -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= } 
  generic TDefaultEqualFunctor<V> = 
    class (specialize TBinaryFunctor<V, Boolean>)
  public
    function Call(AValue1, AValue2 : V) : Boolean; override;
  end;

  { Functors for default types. } 
  TEqualFunctorByte = 
    class(specialize TDefaultEqualFunctor<Byte>);
  TEqualFunctorShortInt = 
    class(specialize TDefaultEqualFunctor<ShortInt>);
  TEqualFunctorWord = 
    class(specialize TDefaultEqualFunctor<Word>);
  TEqualFunctorSmallInt = 
    class(specialize TDefaultEqualFunctor<SmallInt>);
  TEqualFunctorInteger = 
    class(specialize TDefaultEqualFunctor<Integer>);
  TEqualFunctorDWord = 
    class(specialize TDefaultEqualFunctor<DWord>);
  TEqualFunctorCardinal = 
    class(specialize TDefaultEqualFunctor<Cardinal>);
  TEqualFunctorLongWord = 
    class(specialize TDefaultEqualFunctor<LongWord>);
  TEqualFunctorLongInt = 
    class(specialize TDefaultEqualFunctor<LongInt>);
  TEqualFunctorQWord = 
    class(specialize TDefaultEqualFunctor<QWord>);
  TEqualFunctorInt64 = 
    class(specialize TDefaultEqualFunctor<Int64>);
  TEqualFunctorSingle = 
    class(specialize TDefaultEqualFunctor<Single>);
  TEqualFunctorReal = 
    class(specialize TDefaultEqualFunctor<Real>);
  TEqualFunctorDouble = 
    class(specialize TDefaultEqualFunctor<Double>);
  TEqualFunctorExtended = 
    class(specialize TDefaultEqualFunctor<Extended>);
  TEqualFunctorCurrency = 
    class(specialize TDefaultEqualFunctor<Currency>);
  TEqualFunctorBoolean = 
    class(specialize TDefaultEqualFunctor<Boolean>);
  TEqualFunctorChar = 
    class(specialize TDefaultEqualFunctor<Char>);
  TEqualFunctorWideChar = 
    class(specialize TDefaultEqualFunctor<WideChar>);  
  TEqualFunctorString = 
    class(specialize TDefaultEqualFunctor<String>);
  TEqualFunctorWideString = 
    class(specialize TDefaultEqualFunctor<WideString>);

implementation

function TDefaultCompareFunctor.Call(AValue1, AValue2 : V) : Integer;
begin
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
end;

function TUnsortableFunctor.Call (AValue1, AValue2 : V) : Integer;
begin
  Result := 0;
end;

function TDefaultLessFunctor.Call(AValue1, AValue2 : V) : Boolean;
begin
  Result := AValue1 < AValue2;
end;

function TDefaultGreaterFunctor.Call(AValue1, AValue2 : V) : Boolean;
begin
  Result := AValue1 > AValue2;
end;

function TDefaultEqualFunctor.Call(AValue1, AValue2 : V) : Boolean;
begin
  Result := AValue1 = AValue2;
end;

end.

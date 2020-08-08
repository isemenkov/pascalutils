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

  { Unary functor returns Boolean value }
  generic TUnaryLogicFunctor<V> = class
  public
    function Call(AValue : V) : Boolean; virtual; abstract;
  end;  

  { Binary functor returns Boolean value }
  generic TBinaryLogicFunctor<V> = class
  public
    function Call(AValue1, AValue2 : V) : Boolean; virtual; abstract;
  end;  

  { -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    Binary less functors for default types 
    -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
  }   
  TBinaryLogicLessFunctorByte = class(specialize TBinaryLogicFunctor<Byte>)
  public
    function Call(AValue1, AValue2 : Byte) : Boolean; override;
  end;

  TBinaryLogicLessFunctorShortInt = 
    class(specialize TBinaryLogicFunctor<ShortInt>)
  public
    function Call(AValue1, AValue2 : ShortInt) : Boolean; override;
  end;

  TBinaryLogicLessFunctorWord = class(specialize TBinaryLogicFunctor<Word>)
  public
    function Call(AValue1, AValue2 : Word) : Boolean; override;
  end;
  
  TBinaryLogicLessFunctorSmallInt = 
    class(specialize TBinaryLogicFunctor<SmallInt>)
  public
    function Call(AValue1, AValue2 : SmallInt) : Boolean; override;
  end;
  
  TBinaryLogicLessFunctorInteger = 
    class(specialize TBinaryLogicFunctor<Integer>)
  public
    function Call(AValue1, AValue2 : Integer) : Boolean; override;
  end;

  TBinaryLogicLessFunctorDWord = class(specialize TBinaryLogicFunctor<DWord>)
  public
    function Call(AValue1, AValue2 : DWord) : Boolean; override;
  end;

  TBinaryLogicLessFunctorCardinal = 
    class(specialize TBinaryLogicFunctor<Cardinal>)
  public
    function Call(AValue1, AValue2 : Cardinal) : Boolean; override;
  end;
 
  TBinaryLogicLessFunctorLongWord = 
    class(specialize TBinaryLogicFunctor<LongWord>)
  public
    function Call(AValue1, AValue2 : LongWord) : Boolean; override;
  end;

  TBinaryLogicLessFunctorLongInt = 
    class(specialize TBinaryLogicFunctor<LongInt>)
  public
    function Call(AValue1, AValue2 : LongInt) : Boolean; override;
  end;

  TBinaryLogicLessFunctorQWord = class(specialize TBinaryLogicFunctor<QWord>)
  public
    function Call(AValue1, AValue2 : QWord) : Boolean; override;
  end;

  TBinaryLogicLessFunctorInt64 = class(specialize TBinaryLogicFunctor<Int64>)
  public
    function Call(AValue1, AValue2 : Int64) : Boolean; override;
  end;

implementation

function TBinaryLogicLessFunctorByte.Call(AValue1, AValue2 : Byte) : Boolean;
begin
  Result := AValue1 < AValue2;
end;

function TBinaryLogicLessFunctorShortInt.Call(AValue1, AValue2 : ShortInt) : 
  Boolean;
begin
  Result := AValue1 < AValue2;
end;

function TBinaryLogicLessFunctorWord.Call(AValue1, AValue2 : Word) : Boolean;
begin
  Result := AValue1 < AValue2;
end;

function TBinaryLogicLessFunctorSmallInt.Call(AValue1, AValue2 : SmallInt) :
  Boolean;
begin
  Result := AValue1 < AValue2;
end;

function TBinaryLogicLessFunctorInteger.Call(AValue1, AValue2 : Integer) :
  Boolean;
begin
  Result := AValue1 < AValue2;
end;

function TBinaryLogicLessFunctorDWord.Call(AValue1, AValue2 : DWord) : Boolean;
begin
  Result := AValue1 < AValue2;
end;

function TBinaryLogicLessFunctorCardinal.Call(AValue1, AValue2 : Cardinal) : 
  Boolean;
begin
  Result := AValue1 < AValue2;
end;

function TBinaryLogicLessFunctorLongWord.Call(AValue1, AValue2 : LongWord) : 
  Boolean;
begin
  Result := AValue1 < AValue2;
end;

function TBinaryLogicLessFunctorLongInt.Call(AValue1, AValue2 : LongInt) : 
  Boolean;
begin
  Result := AValue1 < AValue2;
end;

function TBinaryLogicLessFunctorQWord.Call(AValue1, AValue2 : QWord) : Boolean;
begin
  Result := AValue1 < AValue2;
end;

function TBinaryLogicLessFunctorInt64.Call(AValue1, AValue2 : Int64) : Boolean;
begin
  Result := AValue1 < AValue2;
end;

end.

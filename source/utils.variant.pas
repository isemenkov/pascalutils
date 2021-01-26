(******************************************************************************)
(*                                PascalUtils                                 *)
(*          delphi and object pascal library of utils data structures         *)
(*                                                                            *)
(* Copyright (c) 2021                                       Ivan Semenkov     *)
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

unit utils.variant;

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
  { Variant value undeined type. }
  ETypeUndefinedException = class(Exception);

  { Wrapper for variant custom value. } 
  TVariantValue = class
  end;

  { Generic for custom variant value implementation. }
  {$IFDEF FPC}generic{$ENDIF} TVariantResultValue<T> = class(TVariantValue)
  public
    constructor Create(AValue : T);
    destructor Destroy; override;
  protected
    FValue : T;
  protected
    { Return concreate variant item value. }
    function Value : T;
  end;

  TValueType = (
    VALUE_TYPE1,
    VALUE_TYPE2,
    VALUE_TYPE3,
    VALUE_TYPE4,
    VALUE_TYPE5,
    VALUE_TYPE6,
    VALUE_TYPE7,
    VALUE_TYPE8,
    VALUE_TYPE9,
    VALUE_TYPE10
  );

  {$IFDEF FPC}generic{$ENDIF} TVariant2<T1, T2> = class
  public
    type
      TVariantValue1 = {$IFDEF FPC}specialize{$ENDIF}
        TVariantResultValue<T1>;
      TVariantValue2 = {$IFDEF FPC}specialize{$ENDIF}
        TVariantResultValue<T2>;
  public
    constructor Create;
    destructor Destroy; override;

    { Return variant value type. }
    function GetType : TValueType;

    { Return variant value. }
    function GetValue : TVariantValue;

    { Set variant value to T1. }
    procedure SetValue (AValue : T1); overload;

    { Set variant value to T2. }
    procedure SetValue (AValue : T2); overload;
  protected
    type
      { Variant T1 data type. }
      PValue1 = ^Value1;
      Value1 = record
        Value : T1;
      end;
      
      { Variant T2 data type. }
      PValue2 = ^Value2;
      Value2 = record
        Value : T2;
      end;
      
      { Variant data container. }
      TValueData = record
      ValueType : TValueType;
      case TValueType of
        VALUE_TYPE1 : (Value1 : PValue1);
        VALUE_TYPE2 : (Value2 : PValue2);
      end;
  protected
    procedure DeleteValue;
  protected
    FValue : TValueData;
  end;

  {$IFDEF FPC}generic{$ENDIF} TVariant3<T1, T2, T3> = class
  public
    type
      TVariantValue1 = {$IFDEF FPC}specialize{$ENDIF}
        TVariantResultValue<T1>;
      TVariantValue2 = {$IFDEF FPC}specialize{$ENDIF}
        TVariantResultValue<T2>;
      TVariantValue3 = {$IFDEF FPC}specialize{$ENDIF}
        TVariantResultValue<T3>;
  public
    constructor Create;
    destructor Destroy; override;

    { Return variant value type. }
    function GetType : TValueType;

    { Return variant value. }
    function GetValue : TVariantValue;

    { Set variant value to T1. }
    procedure SetValue (AValue : T1); overload;

    { Set variant value to T2. }
    procedure SetValue (AValue : T2); overload;

    { Set variant value to T3. }
    procedure SetValue (AValue : T3); overload;
  protected
    type
      { Variant T1 data type. }
      PValue1 = ^Value1;
      Value1 = record
        Value : T1;
      end;
      
      { Variant T2 data type. }
      PValue2 = ^Value2;
      Value2 = record
        Value : T2;
      end;

      { Variant T3 data type. }
      PValue3 = ^Value3;
      Value3 = record
        Value : T3;
      end;
      
      { Variant data container. }
      TValueData = record
      ValueType : TValueType;
      case TValueType of
        VALUE_TYPE1 : (Value1 : PValue1);
        VALUE_TYPE2 : (Value2 : PValue2);
        VALUE_TYPE3 : (Value3 : PValue3);
      end;
  protected
    procedure DeleteValue;
  protected
    FValue : TValueData;
  end;

  {$IFDEF FPC}generic{$ENDIF} TVariant4<T1, T2, T3, T4> = class
  public
    type
      TVariantValue1 = {$IFDEF FPC}specialize{$ENDIF}
        TVariantResultValue<T1>;
      TVariantValue2 = {$IFDEF FPC}specialize{$ENDIF}
        TVariantResultValue<T2>;
      TVariantValue3 = {$IFDEF FPC}specialize{$ENDIF}
        TVariantResultValue<T3>;
      TVariantValue4 = {$IFDEF FPC}specialize{$ENDIF}
        TVariantResultValue<T4>;
  public
    constructor Create;
    destructor Destroy; override;

    { Return variant value type. }
    function GetType : TValueType;

    { Return variant value. }
    function GetValue : TVariantValue;

    { Set variant value to T1. }
    procedure SetValue (AValue : T1); overload;

    { Set variant value to T2. }
    procedure SetValue (AValue : T2); overload;

    { Set variant value to T3. }
    procedure SetValue (AValue : T3); overload;

    { Set variant value to T4. }
    procedure SetValue (AValue : T4); overload;
  protected
    type
      { Variant T1 data type. }
      PValue1 = ^Value1;
      Value1 = record
        Value : T1;
      end;
      
      { Variant T2 data type. }
      PValue2 = ^Value2;
      Value2 = record
        Value : T2;
      end;

      { Variant T3 data type. }
      PValue3 = ^Value3;
      Value3 = record
        Value : T3;
      end;

      { Variant T4 data type. }
      PValue4 = ^Value4;
      Value4 = record
        Value : T4;
      end;
      
      { Variant data container. }
      TValueData = record
      ValueType : TValueType;
      case TValueType of
        VALUE_TYPE1 : (Value1 : PValue1);
        VALUE_TYPE2 : (Value2 : PValue2);
        VALUE_TYPE3 : (Value3 : PValue3);
        VALUE_TYPE4 : (Value4 : PValue4);
      end;
  protected
    procedure DeleteValue;
  protected
    FValue : TValueData;
  end;

  {$IFDEF FPC}generic{$ENDIF} TVariant5<T1, T2, T3, T4, T5> = class
  public
    type
      TVariantValue1 = {$IFDEF FPC}specialize{$ENDIF}
        TVariantResultValue<T1>;
      TVariantValue2 = {$IFDEF FPC}specialize{$ENDIF}
        TVariantResultValue<T2>;
      TVariantValue3 = {$IFDEF FPC}specialize{$ENDIF}
        TVariantResultValue<T3>;
      TVariantValue4 = {$IFDEF FPC}specialize{$ENDIF}
        TVariantResultValue<T4>;
      TVariantValue5 = {$IFDEF FPC}specialize{$ENDIF}
        TVariantResultValue<T5>;
  public
    constructor Create;
    destructor Destroy; override;

    { Return variant value type. }
    function GetType : TValueType;

    { Return variant value. }
    function GetValue : TVariantValue;

    { Set variant value to T1. }
    procedure SetValue (AValue : T1); overload;

    { Set variant value to T2. }
    procedure SetValue (AValue : T2); overload;

    { Set variant value to T3. }
    procedure SetValue (AValue : T3); overload;

    { Set variant value to T4. }
    procedure SetValue (AValue : T4); overload;

    { Set variant value to T5. }
    procedure SetValue (AValue : T5); overload;
  protected
    type
      { Variant T1 data type. }
      PValue1 = ^Value1;
      Value1 = record
        Value : T1;
      end;
      
      { Variant T2 data type. }
      PValue2 = ^Value2;
      Value2 = record
        Value : T2;
      end;

      { Variant T3 data type. }
      PValue3 = ^Value3;
      Value3 = record
        Value : T3;
      end;

      { Variant T4 data type. }
      PValue4 = ^Value4;
      Value4 = record
        Value : T4;
      end;

      { Variant T5 data type. }
      PValue5 = ^Value5;
      Value5 = record
        Value : T5;
      end;
      
      { Variant data container. }
      TValueData = record
      ValueType : TValueType;
      case TValueType of
        VALUE_TYPE1 : (Value1 : PValue1);
        VALUE_TYPE2 : (Value2 : PValue2);
        VALUE_TYPE3 : (Value3 : PValue3);
        VALUE_TYPE4 : (Value4 : PValue4);
        VALUE_TYPE5 : (Value5 : PValue5);
      end;
  protected
    procedure DeleteValue;
  protected
    FValue : TValueData;
  end;

  {$IFDEF FPC}generic{$ENDIF} TVariant6<T1, T2, T3, T4, T5, T6> = class
  public
    type
      TVariantValue1 = {$IFDEF FPC}specialize{$ENDIF}
        TVariantResultValue<T1>;
      TVariantValue2 = {$IFDEF FPC}specialize{$ENDIF}
        TVariantResultValue<T2>;
      TVariantValue3 = {$IFDEF FPC}specialize{$ENDIF}
        TVariantResultValue<T3>;
      TVariantValue4 = {$IFDEF FPC}specialize{$ENDIF}
        TVariantResultValue<T4>;
      TVariantValue5 = {$IFDEF FPC}specialize{$ENDIF}
        TVariantResultValue<T5>;
      TVariantValue6 = {$IFDEF FPC}specialize{$ENDIF}
        TVariantResultValue<T6>;
  public
    constructor Create;
    destructor Destroy; override;

    { Return variant value type. }
    function GetType : TValueType;

    { Return variant value. }
    function GetValue : TVariantValue;

    { Set variant value to T1. }
    procedure SetValue (AValue : T1); overload;

    { Set variant value to T2. }
    procedure SetValue (AValue : T2); overload;

    { Set variant value to T3. }
    procedure SetValue (AValue : T3); overload;

    { Set variant value to T4. }
    procedure SetValue (AValue : T4); overload;

    { Set variant value to T5. }
    procedure SetValue (AValue : T5); overload;

    { Set variant value to T6. }
    procedure SetValue (AValue : T6); overload;
  protected
    type
      { Variant T1 data type. }
      PValue1 = ^Value1;
      Value1 = record
        Value : T1;
      end;
      
      { Variant T2 data type. }
      PValue2 = ^Value2;
      Value2 = record
        Value : T2;
      end;

      { Variant T3 data type. }
      PValue3 = ^Value3;
      Value3 = record
        Value : T3;
      end;

      { Variant T4 data type. }
      PValue4 = ^Value4;
      Value4 = record
        Value : T4;
      end;

      { Variant T5 data type. }
      PValue5 = ^Value5;
      Value5 = record
        Value : T5;
      end;

      { Variant T6 data type. }
      PValue6 = ^Value6;
      Value6 = record
        Value : T6;
      end;
      
      { Variant data container. }
      TValueData = record
      ValueType : TValueType;
      case TValueType of
        VALUE_TYPE1 : (Value1 : PValue1);
        VALUE_TYPE2 : (Value2 : PValue2);
        VALUE_TYPE3 : (Value3 : PValue3);
        VALUE_TYPE4 : (Value4 : PValue4);
        VALUE_TYPE5 : (Value5 : PValue5);
        VALUE_TYPE6 : (Value6 : PValue6);
      end;
  protected
    procedure DeleteValue;
  protected
    FValue : TValueData;
  end;

  {$IFDEF FPC}generic{$ENDIF} TVariant7<T1, T2, T3, T4, T5, T6, T7> = class
  public
    type
      TVariantValue1 = {$IFDEF FPC}specialize{$ENDIF}
        TVariantResultValue<T1>;
      TVariantValue2 = {$IFDEF FPC}specialize{$ENDIF}
        TVariantResultValue<T2>;
      TVariantValue3 = {$IFDEF FPC}specialize{$ENDIF}
        TVariantResultValue<T3>;
      TVariantValue4 = {$IFDEF FPC}specialize{$ENDIF}
        TVariantResultValue<T4>;
      TVariantValue5 = {$IFDEF FPC}specialize{$ENDIF}
        TVariantResultValue<T5>;
      TVariantValue6 = {$IFDEF FPC}specialize{$ENDIF}
        TVariantResultValue<T6>;
      TVariantValue7 = {$IFDEF FPC}specialize{$ENDIF}
        TVariantResultValue<T7>;
  public
    constructor Create;
    destructor Destroy; override;

    { Return variant value type. }
    function GetType : TValueType;

    { Return variant value. }
    function GetValue : TVariantValue;

    { Set variant value to T1. }
    procedure SetValue (AValue : T1); overload;

    { Set variant value to T2. }
    procedure SetValue (AValue : T2); overload;

    { Set variant value to T3. }
    procedure SetValue (AValue : T3); overload;

    { Set variant value to T4. }
    procedure SetValue (AValue : T4); overload;

    { Set variant value to T5. }
    procedure SetValue (AValue : T5); overload;

    { Set variant value to T6. }
    procedure SetValue (AValue : T6); overload;

    { Set variant value to T7. }
    procedure SetValue (AValue : T7); overload;
  protected
    type
      { Variant T1 data type. }
      PValue1 = ^Value1;
      Value1 = record
        Value : T1;
      end;
      
      { Variant T2 data type. }
      PValue2 = ^Value2;
      Value2 = record
        Value : T2;
      end;

      { Variant T3 data type. }
      PValue3 = ^Value3;
      Value3 = record
        Value : T3;
      end;

      { Variant T4 data type. }
      PValue4 = ^Value4;
      Value4 = record
        Value : T4;
      end;

      { Variant T5 data type. }
      PValue5 = ^Value5;
      Value5 = record
        Value : T5;
      end;

      { Variant T6 data type. }
      PValue6 = ^Value6;
      Value6 = record
        Value : T6;
      end;

      { Variant T7 data type. }
      PValue7 = ^Value7;
      Value7 = record
        Value : T7;
      end;
      
      { Variant data container. }
      TValueData = record
      ValueType : TValueType;
      case TValueType of
        VALUE_TYPE1 : (Value1 : PValue1);
        VALUE_TYPE2 : (Value2 : PValue2);
        VALUE_TYPE3 : (Value3 : PValue3);
        VALUE_TYPE4 : (Value4 : PValue4);
        VALUE_TYPE5 : (Value5 : PValue5);
        VALUE_TYPE6 : (Value6 : PValue6);
        VALUE_TYPE7 : (Value7 : PValue7);
      end;
  protected
    procedure DeleteValue;
  protected
    FValue : TValueData;
  end;

  {$IFDEF FPC}generic{$ENDIF} TVariant8<T1, T2, T3, T4, T5, T6, T7, T8> = class
  public
    type
      TVariantValue1 = {$IFDEF FPC}specialize{$ENDIF}
        TVariantResultValue<T1>;
      TVariantValue2 = {$IFDEF FPC}specialize{$ENDIF}
        TVariantResultValue<T2>;
      TVariantValue3 = {$IFDEF FPC}specialize{$ENDIF}
        TVariantResultValue<T3>;
      TVariantValue4 = {$IFDEF FPC}specialize{$ENDIF}
        TVariantResultValue<T4>;
      TVariantValue5 = {$IFDEF FPC}specialize{$ENDIF}
        TVariantResultValue<T5>;
      TVariantValue6 = {$IFDEF FPC}specialize{$ENDIF}
        TVariantResultValue<T6>;
      TVariantValue7 = {$IFDEF FPC}specialize{$ENDIF}
        TVariantResultValue<T7>;
      TVariantValue8 = {$IFDEF FPC}specialize{$ENDIF}
        TVariantResultValue<T8>;
  public
    constructor Create;
    destructor Destroy; override;

    { Return variant value type. }
    function GetType : TValueType;

    { Return variant value. }
    function GetValue : TVariantValue;

    { Set variant value to T1. }
    procedure SetValue (AValue : T1); overload;

    { Set variant value to T2. }
    procedure SetValue (AValue : T2); overload;

    { Set variant value to T3. }
    procedure SetValue (AValue : T3); overload;

    { Set variant value to T4. }
    procedure SetValue (AValue : T4); overload;

    { Set variant value to T5. }
    procedure SetValue (AValue : T5); overload;

    { Set variant value to T6. }
    procedure SetValue (AValue : T6); overload;

    { Set variant value to T7. }
    procedure SetValue (AValue : T7); overload;

    { Set variant value to T8. }
    procedure SetValue (AValue : T8); overload;
  protected
    type
      { Variant T1 data type. }
      PValue1 = ^Value1;
      Value1 = record
        Value : T1;
      end;
      
      { Variant T2 data type. }
      PValue2 = ^Value2;
      Value2 = record
        Value : T2;
      end;

      { Variant T3 data type. }
      PValue3 = ^Value3;
      Value3 = record
        Value : T3;
      end;

      { Variant T4 data type. }
      PValue4 = ^Value4;
      Value4 = record
        Value : T4;
      end;

      { Variant T5 data type. }
      PValue5 = ^Value5;
      Value5 = record
        Value : T5;
      end;

      { Variant T6 data type. }
      PValue6 = ^Value6;
      Value6 = record
        Value : T6;
      end;

      { Variant T7 data type. }
      PValue7 = ^Value7;
      Value7 = record
        Value : T7;
      end;

      { Variant T8 data type. }
      PValue8 = ^Value8;
      Value8 = record
        Value : T8;
      end;
      
      { Variant data container. }
      TValueData = record
      ValueType : TValueType;
      case TValueType of
        VALUE_TYPE1 : (Value1 : PValue1);
        VALUE_TYPE2 : (Value2 : PValue2);
        VALUE_TYPE3 : (Value3 : PValue3);
        VALUE_TYPE4 : (Value4 : PValue4);
        VALUE_TYPE5 : (Value5 : PValue5);
        VALUE_TYPE6 : (Value6 : PValue6);
        VALUE_TYPE7 : (Value7 : PValue7);
        VALUE_TYPE8 : (Value8 : PValue8);
      end;
  protected
    procedure DeleteValue;
  protected
    FValue : TValueData;
  end;

  {$IFDEF FPC}generic{$ENDIF} TVariant9<T1, T2, T3, T4, T5, T6, T7, T8, T9> = 
    class
  public
    type
      TVariantValue1 = {$IFDEF FPC}specialize{$ENDIF}
        TVariantResultValue<T1>;
      TVariantValue2 = {$IFDEF FPC}specialize{$ENDIF}
        TVariantResultValue<T2>;
      TVariantValue3 = {$IFDEF FPC}specialize{$ENDIF}
        TVariantResultValue<T3>;
      TVariantValue4 = {$IFDEF FPC}specialize{$ENDIF}
        TVariantResultValue<T4>;
      TVariantValue5 = {$IFDEF FPC}specialize{$ENDIF}
        TVariantResultValue<T5>;
      TVariantValue6 = {$IFDEF FPC}specialize{$ENDIF}
        TVariantResultValue<T6>;
      TVariantValue7 = {$IFDEF FPC}specialize{$ENDIF}
        TVariantResultValue<T7>;
      TVariantValue8 = {$IFDEF FPC}specialize{$ENDIF}
        TVariantResultValue<T8>;
      TVariantValue9 = {$IFDEF FPC}specialize{$ENDIF}
        TVariantResultValue<T9>;
  public
    constructor Create;
    destructor Destroy; override;

    { Return variant value type. }
    function GetType : TValueType;

    { Return variant value. }
    function GetValue : TVariantValue;

    { Set variant value to T1. }
    procedure SetValue (AValue : T1); overload;

    { Set variant value to T2. }
    procedure SetValue (AValue : T2); overload;

    { Set variant value to T3. }
    procedure SetValue (AValue : T3); overload;

    { Set variant value to T4. }
    procedure SetValue (AValue : T4); overload;

    { Set variant value to T5. }
    procedure SetValue (AValue : T5); overload;

    { Set variant value to T6. }
    procedure SetValue (AValue : T6); overload;

    { Set variant value to T7. }
    procedure SetValue (AValue : T7); overload;

    { Set variant value to T8. }
    procedure SetValue (AValue : T8); overload;

    { Set variant value to T9. }
    procedure SetValue (AValue : T9); overload;
  protected
    type
      { Variant T1 data type. }
      PValue1 = ^Value1;
      Value1 = record
        Value : T1;
      end;
      
      { Variant T2 data type. }
      PValue2 = ^Value2;
      Value2 = record
        Value : T2;
      end;

      { Variant T3 data type. }
      PValue3 = ^Value3;
      Value3 = record
        Value : T3;
      end;

      { Variant T4 data type. }
      PValue4 = ^Value4;
      Value4 = record
        Value : T4;
      end;

      { Variant T5 data type. }
      PValue5 = ^Value5;
      Value5 = record
        Value : T5;
      end;

      { Variant T6 data type. }
      PValue6 = ^Value6;
      Value6 = record
        Value : T6;
      end;

      { Variant T7 data type. }
      PValue7 = ^Value7;
      Value7 = record
        Value : T7;
      end;

      { Variant T8 data type. }
      PValue8 = ^Value8;
      Value8 = record
        Value : T8;
      end;

      { Variant T9 data type. }
      PValue9 = ^Value9;
      Value9 = record
        Value : T9;
      end;
      
      { Variant data container. }
      TValueData = record
      ValueType : TValueType;
      case TValueType of
        VALUE_TYPE1 : (Value1 : PValue1);
        VALUE_TYPE2 : (Value2 : PValue2);
        VALUE_TYPE3 : (Value3 : PValue3);
        VALUE_TYPE4 : (Value4 : PValue4);
        VALUE_TYPE5 : (Value5 : PValue5);
        VALUE_TYPE6 : (Value6 : PValue6);
        VALUE_TYPE7 : (Value7 : PValue7);
        VALUE_TYPE8 : (Value8 : PValue8);
        VALUE_TYPE9 : (Value9 : PValue9);
      end;
  protected
    procedure DeleteValue;
  protected
    FValue : TValueData;
  end;

  {$IFDEF FPC}generic{$ENDIF} TVariant10<T1, T2, T3, T4, T5, T6, T7, T8, T9, 
    T10> = class
  public
    type
      TVariantValue1 = {$IFDEF FPC}specialize{$ENDIF}
        TVariantResultValue<T1>;
      TVariantValue2 = {$IFDEF FPC}specialize{$ENDIF}
        TVariantResultValue<T2>;
      TVariantValue3 = {$IFDEF FPC}specialize{$ENDIF}
        TVariantResultValue<T3>;
      TVariantValue4 = {$IFDEF FPC}specialize{$ENDIF}
        TVariantResultValue<T4>;
      TVariantValue5 = {$IFDEF FPC}specialize{$ENDIF}
        TVariantResultValue<T5>;
      TVariantValue6 = {$IFDEF FPC}specialize{$ENDIF}
        TVariantResultValue<T6>;
      TVariantValue7 = {$IFDEF FPC}specialize{$ENDIF}
        TVariantResultValue<T7>;
      TVariantValue8 = {$IFDEF FPC}specialize{$ENDIF}
        TVariantResultValue<T8>;
      TVariantValue9 = {$IFDEF FPC}specialize{$ENDIF}
        TVariantResultValue<T9>;
      TVariantValue10 = {$IFDEF FPC}specialize{$ENDIF}
        TVariantResultValue<T10>;
  public
    constructor Create;
    destructor Destroy; override;

    { Return variant value type. }
    function GetType : TValueType;

    { Return variant value. }
    function GetValue : TVariantValue;

    { Set variant value to T1. }
    procedure SetValue (AValue : T1); overload;

    { Set variant value to T2. }
    procedure SetValue (AValue : T2); overload;

    { Set variant value to T3. }
    procedure SetValue (AValue : T3); overload;

    { Set variant value to T4. }
    procedure SetValue (AValue : T4); overload;

    { Set variant value to T5. }
    procedure SetValue (AValue : T5); overload;

    { Set variant value to T6. }
    procedure SetValue (AValue : T6); overload;

    { Set variant value to T7. }
    procedure SetValue (AValue : T7); overload;

    { Set variant value to T8. }
    procedure SetValue (AValue : T8); overload;

    { Set variant value to T9. }
    procedure SetValue (AValue : T9); overload;

    { Set variant value to T10. }
    procedure SetValue (AValue : T10); overload;
  protected
    type
      { Variant T1 data type. }
      PValue1 = ^Value1;
      Value1 = record
        Value : T1;
      end;
      
      { Variant T2 data type. }
      PValue2 = ^Value2;
      Value2 = record
        Value : T2;
      end;

      { Variant T3 data type. }
      PValue3 = ^Value3;
      Value3 = record
        Value : T3;
      end;

      { Variant T4 data type. }
      PValue4 = ^Value4;
      Value4 = record
        Value : T4;
      end;

      { Variant T5 data type. }
      PValue5 = ^Value5;
      Value5 = record
        Value : T5;
      end;

      { Variant T6 data type. }
      PValue6 = ^Value6;
      Value6 = record
        Value : T6;
      end;

      { Variant T7 data type. }
      PValue7 = ^Value7;
      Value7 = record
        Value : T7;
      end;

      { Variant T8 data type. }
      PValue8 = ^Value8;
      Value8 = record
        Value : T8;
      end;

      { Variant T9 data type. }
      PValue9 = ^Value9;
      Value9 = record
        Value : T9;
      end;

      { Variant T10 data type. }
      PValue10 = ^Value10;
      Value10 = record
        Value : T10;
      end;
      
      { Variant data container. }
      TValueData = record
      ValueType : TValueType;
      case TValueType of
        VALUE_TYPE1 : (Value1 : PValue1);
        VALUE_TYPE2 : (Value2 : PValue2);
        VALUE_TYPE3 : (Value3 : PValue3);
        VALUE_TYPE4 : (Value4 : PValue4);
        VALUE_TYPE5 : (Value5 : PValue5);
        VALUE_TYPE6 : (Value6 : PValue6);
        VALUE_TYPE7 : (Value7 : PValue7);
        VALUE_TYPE8 : (Value8 : PValue8);
        VALUE_TYPE9 : (Value9 : PValue9);
        VALUE_TYPE10 : (Value10 : PValue10);
      end;
  protected
    procedure DeleteValue;
  protected
    FValue : TValueData;
  end;

implementation

{ TVariantResultValue }

constructor TVariantResultValue{$IFNDEF FPC}<T>{$ENDIF}.Create (AValue : T);
begin
  inherited Create;
  FValue := AValue;
end;

destructor TVariantResultValue{$IFNDEF FPC}<T>{$ENDIF}.Destroy;
begin
  inherited Destroy;
end;

function TVariantResultValue{$IFNDEF FPC}<T>{$ENDIF}.Value : T;
begin
  Result := FValue;
end;

{ TVariant2 }

constructor TVariant2{$IFNDEF FPC}<T1, T2>{$ENDIF}.Create;
begin
  FValue.ValueType := VALUE_TYPE1;
  New(FValue.Value1);
  FValue.Value1^.Value := Default(T1);
end;

destructor TVariant2{$IFNDEF FPC}<T1, T2>{$ENDIF}.Destroy;
begin
  DeleteValue;
  inherited Destroy;
end;

procedure TVariant2{$IFNDEF FPC}<T1, T2>{$ENDIF}.DeleteValue;
begin
  case FValue.ValueType of
    VALUE_TYPE1 : begin
      Dispose(FValue.Value1);
    end;
    VALUE_TYPE2 : begin
      Dispose(FValue.Value2);
    end;
  end;
end;

function TVariant2{$IFNDEF FPC}<T1, T2>{$ENDIF}.GetType : TValueType;
begin
  Result := FValue.ValueType;
end;

function TVariant2{$IFNDEF FPC}<T1, T2>{$ENDIF}.GetValue : TVariantValue;
begin
  case FValue.ValueType of
    VALUE_TYPE1 : begin
      Exit(TVariantValue1.Create(FValue.Value1^.Value));
    end;
    VALUE_TYPE2 : begin
      Exit(TVariantValue2.Create(FValue.Value2^.Value));
    end;
  end;

  raise ETypeUndefinedException.Create('Variant udefined type.');
end;

procedure TVariant2{$IFNDEF FPC}<T1, T2>{$ENDIF}.SetValue (AValue : T1);
begin
  if FValue.ValueType <> VALUE_TYPE1 then
  begin  
    DeleteValue;
    FValue.ValueType := VALUE_TYPE1;
    New(FValue.Value1);
  end;

  FValue.Value1^.Value := AValue;
end;

procedure TVariant2{$IFNDEF FPC}<T1, T2>{$ENDIF}.SetValue (AValue : T2);
begin
  if FValue.ValueType <> VALUE_TYPE2 then
  begin
    DeleteValue;
    FValue.ValueType := VALUE_TYPE2;
    New(FValue.Value2);
  end;
  
  FValue.Value2^.Value := AValue;
end;

{ TVariant3 }

constructor TVariant3{$IFNDEF FPC}<T1, T2, T3>{$ENDIF}.Create;
begin
  FValue.ValueType := VALUE_TYPE1;
  New(FValue.Value1);
  FValue.Value1^.Value := Default(T1);
end;

destructor TVariant3{$IFNDEF FPC}<T1, T2, T3>{$ENDIF}.Destroy;
begin
  DeleteValue;
  inherited Destroy;
end;

procedure TVariant3{$IFNDEF FPC}<T1, T2, T3>{$ENDIF}.DeleteValue;
begin
  case FValue.ValueType of
    VALUE_TYPE1 : begin
      Dispose(FValue.Value1);
    end;
    VALUE_TYPE2 : begin
      Dispose(FValue.Value2);
    end;
    VALUE_TYPE3 : begin
      Dispose(FValue.Value3);
    end;
  end;
end;

function TVariant3{$IFNDEF FPC}<T1, T2, T3>{$ENDIF}.GetType : TValueType;
begin
  Result := FValue.ValueType;
end;

function TVariant3{$IFNDEF FPC}<T1, T2, T3>{$ENDIF}.GetValue : TVariantValue;
begin
  case FValue.ValueType of
    VALUE_TYPE1 : begin
      Exit(TVariantValue1.Create(FValue.Value1^.Value));
    end;
    VALUE_TYPE2 : begin
      Exit(TVariantValue2.Create(FValue.Value2^.Value));
    end;
    VALUE_TYPE3 : begin
      Exit(TVariantValue3.Create(FValue.Value3^.Value));
    end;
  end;

  raise ETypeUndefinedException.Create('Variant udefined type.');
end;

procedure TVariant3{$IFNDEF FPC}<T1, T2, T3>{$ENDIF}.SetValue (AValue : T1);
begin
  if FValue.ValueType <> VALUE_TYPE1 then
  begin  
    DeleteValue;
    FValue.ValueType := VALUE_TYPE1;
    New(FValue.Value1);
  end;

  FValue.Value1^.Value := AValue;
end;

procedure TVariant3{$IFNDEF FPC}<T1, T2, T3>{$ENDIF}.SetValue (AValue : T2);
begin
  if FValue.ValueType <> VALUE_TYPE2 then
  begin
    DeleteValue;
    FValue.ValueType := VALUE_TYPE2;
    New(FValue.Value2);
  end;
  
  FValue.Value2^.Value := AValue;
end;

procedure TVariant3{$IFNDEF FPC}<T1, T2, T3>{$ENDIF}.SetValue (AValue : T3);
begin
  if FValue.ValueType <> VALUE_TYPE3 then
  begin
    DeleteValue;
    FValue.ValueType := VALUE_TYPE3;
    New(FValue.Value3);
  end;
  
  FValue.Value3^.Value := AValue;
end;

{ TVariant4 }

constructor TVariant4{$IFNDEF FPC}<T1, T2, T3, T4>{$ENDIF}.Create;
begin
  FValue.ValueType := VALUE_TYPE1;
  New(FValue.Value1);
  FValue.Value1^.Value := Default(T1);
end;

destructor TVariant4{$IFNDEF FPC}<T1, T2, T3, T4>{$ENDIF}.Destroy;
begin
  DeleteValue;
  inherited Destroy;
end;

procedure TVariant4{$IFNDEF FPC}<T1, T2, T3, T4>{$ENDIF}.DeleteValue;
begin
  case FValue.ValueType of
    VALUE_TYPE1 : begin
      Dispose(FValue.Value1);
    end;
    VALUE_TYPE2 : begin
      Dispose(FValue.Value2);
    end;
    VALUE_TYPE3 : begin
      Dispose(FValue.Value3);
    end;
    VALUE_TYPE4 : begin
      Dispose(FValue.Value4);
    end;
  end;
end;

function TVariant4{$IFNDEF FPC}<T1, T2, T3, T4>{$ENDIF}.GetType : TValueType;
begin
  Result := FValue.ValueType;
end;

function TVariant4{$IFNDEF FPC}<T1, T2, T3, T4>{$ENDIF}.GetValue : 
  TVariantValue;
begin
  case FValue.ValueType of
    VALUE_TYPE1 : begin
      Exit(TVariantValue1.Create(FValue.Value1^.Value));
    end;
    VALUE_TYPE2 : begin
      Exit(TVariantValue2.Create(FValue.Value2^.Value));
    end;
    VALUE_TYPE3 : begin
      Exit(TVariantValue3.Create(FValue.Value3^.Value));
    end;
    VALUE_TYPE4 : begin
      Exit(TVariantValue4.Create(FValue.Value4^.Value));
    end;
  end;

  raise ETypeUndefinedException.Create('Variant udefined type.');
end;

procedure TVariant4{$IFNDEF FPC}<T1, T2, T3, T4>{$ENDIF}.SetValue (AValue : T1);
begin
  if FValue.ValueType <> VALUE_TYPE1 then
  begin  
    DeleteValue;
    FValue.ValueType := VALUE_TYPE1;
    New(FValue.Value1);
  end;

  FValue.Value1^.Value := AValue;
end;

procedure TVariant4{$IFNDEF FPC}<T1, T2, T3, T4>{$ENDIF}.SetValue (AValue : T2);
begin
  if FValue.ValueType <> VALUE_TYPE2 then
  begin
    DeleteValue;
    FValue.ValueType := VALUE_TYPE2;
    New(FValue.Value2);
  end;
  
  FValue.Value2^.Value := AValue;
end;

procedure TVariant4{$IFNDEF FPC}<T1, T2, T3, T4>{$ENDIF}.SetValue (AValue : T3);
begin
  if FValue.ValueType <> VALUE_TYPE3 then
  begin
    DeleteValue;
    FValue.ValueType := VALUE_TYPE3;
    New(FValue.Value3);
  end;
  
  FValue.Value3^.Value := AValue;
end;

procedure TVariant4{$IFNDEF FPC}<T1, T2, T3, T4>{$ENDIF}.SetValue (AValue : T4);
begin
  if FValue.ValueType <> VALUE_TYPE4 then
  begin
    DeleteValue;
    FValue.ValueType := VALUE_TYPE4;
    New(FValue.Value4);
  end;
  
  FValue.Value4^.Value := AValue;
end;

{ TVariant5 }

constructor TVariant5{$IFNDEF FPC}<T1, T2, T3, T4, T5>{$ENDIF}.Create;
begin
  FValue.ValueType := VALUE_TYPE1;
  New(FValue.Value1);
  FValue.Value1^.Value := Default(T1);
end;

destructor TVariant5{$IFNDEF FPC}<T1, T2, T3, T4, T5>{$ENDIF}.Destroy;
begin
  DeleteValue;
  inherited Destroy;
end;

procedure TVariant5{$IFNDEF FPC}<T1, T2, T3, T4, T5>{$ENDIF}.DeleteValue;
begin
  case FValue.ValueType of
    VALUE_TYPE1 : begin
      Dispose(FValue.Value1);
    end;
    VALUE_TYPE2 : begin
      Dispose(FValue.Value2);
    end;
    VALUE_TYPE3 : begin
      Dispose(FValue.Value3);
    end;
    VALUE_TYPE4 : begin
      Dispose(FValue.Value4);
    end;
    VALUE_TYPE5 : begin
      Dispose(FValue.Value5);
    end;
  end;
end;

function TVariant5{$IFNDEF FPC}<T1, T2, T3, T4, T5>{$ENDIF}.GetType : 
  TValueType;
begin
  Result := FValue.ValueType;
end;

function TVariant5{$IFNDEF FPC}<T1, T2, T3, T4, T5>{$ENDIF}.GetValue : 
  TVariantValue;
begin
  case FValue.ValueType of
    VALUE_TYPE1 : begin
      Exit(TVariantValue1.Create(FValue.Value1^.Value));
    end;
    VALUE_TYPE2 : begin
      Exit(TVariantValue2.Create(FValue.Value2^.Value));
    end;
    VALUE_TYPE3 : begin
      Exit(TVariantValue3.Create(FValue.Value3^.Value));
    end;
    VALUE_TYPE4 : begin
      Exit(TVariantValue4.Create(FValue.Value4^.Value));
    end;
    VALUE_TYPE5 : begin
      Exit(TVariantValue5.Create(FValue.Value5^.Value));
    end;
  end;

  raise ETypeUndefinedException.Create('Variant udefined type.');
end;

procedure TVariant5{$IFNDEF FPC}<T1, T2, T3, T4, T5>{$ENDIF}.SetValue (AValue : 
  T1);
begin
  if FValue.ValueType <> VALUE_TYPE1 then
  begin  
    DeleteValue;
    FValue.ValueType := VALUE_TYPE1;
    New(FValue.Value1);
  end;

  FValue.Value1^.Value := AValue;
end;

procedure TVariant5{$IFNDEF FPC}<T1, T2, T3, T4, T5>{$ENDIF}.SetValue (AValue : 
  T2);
begin
  if FValue.ValueType <> VALUE_TYPE2 then
  begin
    DeleteValue;
    FValue.ValueType := VALUE_TYPE2;
    New(FValue.Value2);
  end;
  
  FValue.Value2^.Value := AValue;
end;

procedure TVariant5{$IFNDEF FPC}<T1, T2, T3, T4, T5>{$ENDIF}.SetValue (AValue : 
  T3);
begin
  if FValue.ValueType <> VALUE_TYPE3 then
  begin
    DeleteValue;
    FValue.ValueType := VALUE_TYPE3;
    New(FValue.Value3);
  end;
  
  FValue.Value3^.Value := AValue;
end;

procedure TVariant5{$IFNDEF FPC}<T1, T2, T3, T4, T5>{$ENDIF}.SetValue (AValue : 
  T4);
begin
  if FValue.ValueType <> VALUE_TYPE4 then
  begin
    DeleteValue;
    FValue.ValueType := VALUE_TYPE4;
    New(FValue.Value4);
  end;
  
  FValue.Value4^.Value := AValue;
end;

procedure TVariant5{$IFNDEF FPC}<T1, T2, T3, T4, T5>{$ENDIF}.SetValue (AValue : 
  T5);
begin
  if FValue.ValueType <> VALUE_TYPE5 then
  begin
    DeleteValue;
    FValue.ValueType := VALUE_TYPE5;
    New(FValue.Value5);
  end;
  
  FValue.Value5^.Value := AValue;
end;

{ TVariant6 }

constructor TVariant6{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6>{$ENDIF}.Create;
begin
  FValue.ValueType := VALUE_TYPE1;
  New(FValue.Value1);
  FValue.Value1^.Value := Default(T1);
end;

destructor TVariant6{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6>{$ENDIF}.Destroy;
begin
  DeleteValue;
  inherited Destroy;
end;

procedure TVariant6{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6>{$ENDIF}.DeleteValue;
begin
  case FValue.ValueType of
    VALUE_TYPE1 : begin
      Dispose(FValue.Value1);
    end;
    VALUE_TYPE2 : begin
      Dispose(FValue.Value2);
    end;
    VALUE_TYPE3 : begin
      Dispose(FValue.Value3);
    end;
    VALUE_TYPE4 : begin
      Dispose(FValue.Value4);
    end;
    VALUE_TYPE5 : begin
      Dispose(FValue.Value5);
    end;
    VALUE_TYPE6 : begin
      Dispose(FValue.Value6);
    end;
  end;
end;

function TVariant6{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6>{$ENDIF}.GetType : 
  TValueType;
begin
  Result := FValue.ValueType;
end;

function TVariant6{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6>{$ENDIF}.GetValue : 
  TVariantValue;
begin
  case FValue.ValueType of
    VALUE_TYPE1 : begin
      Exit(TVariantValue1.Create(FValue.Value1^.Value));
    end;
    VALUE_TYPE2 : begin
      Exit(TVariantValue2.Create(FValue.Value2^.Value));
    end;
    VALUE_TYPE3 : begin
      Exit(TVariantValue3.Create(FValue.Value3^.Value));
    end;
    VALUE_TYPE4 : begin
      Exit(TVariantValue4.Create(FValue.Value4^.Value));
    end;
    VALUE_TYPE5 : begin
      Exit(TVariantValue5.Create(FValue.Value5^.Value));
    end;
    VALUE_TYPE6 : begin
      Exit(TVariantValue6.Create(FValue.Value6^.Value));
    end;
  end;

  raise ETypeUndefinedException.Create('Variant udefined type.');
end;

procedure TVariant6{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6>{$ENDIF}.SetValue 
  (AValue : T1);
begin
  if FValue.ValueType <> VALUE_TYPE1 then
  begin  
    DeleteValue;
    FValue.ValueType := VALUE_TYPE1;
    New(FValue.Value1);
  end;

  FValue.Value1^.Value := AValue;
end;

procedure TVariant6{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6>{$ENDIF}.SetValue 
  (AValue : T2);
begin
  if FValue.ValueType <> VALUE_TYPE2 then
  begin
    DeleteValue;
    FValue.ValueType := VALUE_TYPE2;
    New(FValue.Value2);
  end;
  
  FValue.Value2^.Value := AValue;
end;

procedure TVariant6{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6>{$ENDIF}.SetValue 
  (AValue : T3);
begin
  if FValue.ValueType <> VALUE_TYPE3 then
  begin
    DeleteValue;
    FValue.ValueType := VALUE_TYPE3;
    New(FValue.Value3);
  end;
  
  FValue.Value3^.Value := AValue;
end;

procedure TVariant6{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6>{$ENDIF}.SetValue 
  (AValue : T4);
begin
  if FValue.ValueType <> VALUE_TYPE4 then
  begin
    DeleteValue;
    FValue.ValueType := VALUE_TYPE4;
    New(FValue.Value4);
  end;
  
  FValue.Value4^.Value := AValue;
end;

procedure TVariant6{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6>{$ENDIF}.SetValue 
  (AValue : T5);
begin
  if FValue.ValueType <> VALUE_TYPE5 then
  begin
    DeleteValue;
    FValue.ValueType := VALUE_TYPE5;
    New(FValue.Value5);
  end;
  
  FValue.Value5^.Value := AValue;
end;

procedure TVariant6{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6>{$ENDIF}.SetValue 
  (AValue : T6);
begin
  if FValue.ValueType <> VALUE_TYPE6 then
  begin
    DeleteValue;
    FValue.ValueType := VALUE_TYPE6;
    New(FValue.Value6);
  end;
  
  FValue.Value6^.Value := AValue;
end;

{ TVariant7 }

constructor TVariant7{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7>{$ENDIF}.Create;
begin
  FValue.ValueType := VALUE_TYPE1;
  New(FValue.Value1);
  FValue.Value1^.Value := Default(T1);
end;

destructor TVariant7{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7>{$ENDIF}.Destroy;
begin
  DeleteValue;
  inherited Destroy;
end;

procedure TVariant7{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7>{$ENDIF}
  .DeleteValue;
begin
  case FValue.ValueType of
    VALUE_TYPE1 : begin
      Dispose(FValue.Value1);
    end;
    VALUE_TYPE2 : begin
      Dispose(FValue.Value2);
    end;
    VALUE_TYPE3 : begin
      Dispose(FValue.Value3);
    end;
    VALUE_TYPE4 : begin
      Dispose(FValue.Value4);
    end;
    VALUE_TYPE5 : begin
      Dispose(FValue.Value5);
    end;
    VALUE_TYPE6 : begin
      Dispose(FValue.Value6);
    end;
    VALUE_TYPE7 : begin
      Dispose(FValue.Value7);
    end;
  end;
end;

function TVariant7{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7>{$ENDIF}.GetType : 
  TValueType;
begin
  Result := FValue.ValueType;
end;

function TVariant7{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7>{$ENDIF}.GetValue : 
  TVariantValue;
begin
  case FValue.ValueType of
    VALUE_TYPE1 : begin
      Exit(TVariantValue1.Create(FValue.Value1^.Value));
    end;
    VALUE_TYPE2 : begin
      Exit(TVariantValue2.Create(FValue.Value2^.Value));
    end;
    VALUE_TYPE3 : begin
      Exit(TVariantValue3.Create(FValue.Value3^.Value));
    end;
    VALUE_TYPE4 : begin
      Exit(TVariantValue4.Create(FValue.Value4^.Value));
    end;
    VALUE_TYPE5 : begin
      Exit(TVariantValue5.Create(FValue.Value5^.Value));
    end;
    VALUE_TYPE6 : begin
      Exit(TVariantValue6.Create(FValue.Value6^.Value));
    end;
    VALUE_TYPE7 : begin
      Exit(TVariantValue7.Create(FValue.Value7^.Value));
    end;
  end;

  raise ETypeUndefinedException.Create('Variant udefined type.');
end;

procedure TVariant7{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7>{$ENDIF}.SetValue 
  (AValue : T1);
begin
  if FValue.ValueType <> VALUE_TYPE1 then
  begin  
    DeleteValue;
    FValue.ValueType := VALUE_TYPE1;
    New(FValue.Value1);
  end;

  FValue.Value1^.Value := AValue;
end;

procedure TVariant7{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7>{$ENDIF}.SetValue 
  (AValue : T2);
begin
  if FValue.ValueType <> VALUE_TYPE2 then
  begin
    DeleteValue;
    FValue.ValueType := VALUE_TYPE2;
    New(FValue.Value2);
  end;
  
  FValue.Value2^.Value := AValue;
end;

procedure TVariant7{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7>{$ENDIF}.SetValue 
  (AValue : T3);
begin
  if FValue.ValueType <> VALUE_TYPE3 then
  begin
    DeleteValue;
    FValue.ValueType := VALUE_TYPE3;
    New(FValue.Value3);
  end;
  
  FValue.Value3^.Value := AValue;
end;

procedure TVariant7{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7>{$ENDIF}.SetValue 
  (AValue : T4);
begin
  if FValue.ValueType <> VALUE_TYPE4 then
  begin
    DeleteValue;
    FValue.ValueType := VALUE_TYPE4;
    New(FValue.Value4);
  end;
  
  FValue.Value4^.Value := AValue;
end;

procedure TVariant7{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7>{$ENDIF}.SetValue 
  (AValue : T5);
begin
  if FValue.ValueType <> VALUE_TYPE5 then
  begin
    DeleteValue;
    FValue.ValueType := VALUE_TYPE5;
    New(FValue.Value5);
  end;
  
  FValue.Value5^.Value := AValue;
end;

procedure TVariant7{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7>{$ENDIF}.SetValue 
  (AValue : T6);
begin
  if FValue.ValueType <> VALUE_TYPE6 then
  begin
    DeleteValue;
    FValue.ValueType := VALUE_TYPE6;
    New(FValue.Value6);
  end;
  
  FValue.Value6^.Value := AValue;
end;

procedure TVariant7{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7>{$ENDIF}.SetValue 
  (AValue : T7);
begin
  if FValue.ValueType <> VALUE_TYPE7 then
  begin
    DeleteValue;
    FValue.ValueType := VALUE_TYPE7;
    New(FValue.Value7);
  end;
  
  FValue.Value7^.Value := AValue;
end;

{ TVariant8 }

constructor TVariant8{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7, T8>{$ENDIF}
  .Create;
begin
  FValue.ValueType := VALUE_TYPE1;
  New(FValue.Value1);
  FValue.Value1^.Value := Default(T1);
end;

destructor TVariant8{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7, T8>{$ENDIF}
  .Destroy;
begin
  DeleteValue;
  inherited Destroy;
end;

procedure TVariant8{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7, T8>{$ENDIF}
  .DeleteValue;
begin
  case FValue.ValueType of
    VALUE_TYPE1 : begin
      Dispose(FValue.Value1);
    end;
    VALUE_TYPE2 : begin
      Dispose(FValue.Value2);
    end;
    VALUE_TYPE3 : begin
      Dispose(FValue.Value3);
    end;
    VALUE_TYPE4 : begin
      Dispose(FValue.Value4);
    end;
    VALUE_TYPE5 : begin
      Dispose(FValue.Value5);
    end;
    VALUE_TYPE6 : begin
      Dispose(FValue.Value6);
    end;
    VALUE_TYPE7 : begin
      Dispose(FValue.Value7);
    end;
    VALUE_TYPE8 : begin
      Dispose(FValue.Value8);
    end;
  end;
end;

function TVariant8{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7, T8>{$ENDIF}
  .GetType : TValueType;
begin
  Result := FValue.ValueType;
end;

function TVariant8{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7, T8>{$ENDIF}
  .GetValue : TVariantValue;
begin
  case FValue.ValueType of
    VALUE_TYPE1 : begin
      Exit(TVariantValue1.Create(FValue.Value1^.Value));
    end;
    VALUE_TYPE2 : begin
      Exit(TVariantValue2.Create(FValue.Value2^.Value));
    end;
    VALUE_TYPE3 : begin
      Exit(TVariantValue3.Create(FValue.Value3^.Value));
    end;
    VALUE_TYPE4 : begin
      Exit(TVariantValue4.Create(FValue.Value4^.Value));
    end;
    VALUE_TYPE5 : begin
      Exit(TVariantValue5.Create(FValue.Value5^.Value));
    end;
    VALUE_TYPE6 : begin
      Exit(TVariantValue6.Create(FValue.Value6^.Value));
    end;
    VALUE_TYPE7 : begin
      Exit(TVariantValue7.Create(FValue.Value7^.Value));
    end;
    VALUE_TYPE8 : begin
      Exit(TVariantValue8.Create(FValue.Value8^.Value));
    end;
  end;

  raise ETypeUndefinedException.Create('Variant udefined type.');
end;

procedure TVariant8{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7, T8>{$ENDIF}
  .SetValue (AValue : T1);
begin
  if FValue.ValueType <> VALUE_TYPE1 then
  begin  
    DeleteValue;
    FValue.ValueType := VALUE_TYPE1;
    New(FValue.Value1);
  end;

  FValue.Value1^.Value := AValue;
end;

procedure TVariant8{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7, T8>{$ENDIF}
  .SetValue (AValue : T2);
begin
  if FValue.ValueType <> VALUE_TYPE2 then
  begin
    DeleteValue;
    FValue.ValueType := VALUE_TYPE2;
    New(FValue.Value2);
  end;
  
  FValue.Value2^.Value := AValue;
end;

procedure TVariant8{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7, T8>{$ENDIF}
  .SetValue (AValue : T3);
begin
  if FValue.ValueType <> VALUE_TYPE3 then
  begin
    DeleteValue;
    FValue.ValueType := VALUE_TYPE3;
    New(FValue.Value3);
  end;
  
  FValue.Value3^.Value := AValue;
end;

procedure TVariant8{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7, T8>{$ENDIF}
  .SetValue (AValue : T4);
begin
  if FValue.ValueType <> VALUE_TYPE4 then
  begin
    DeleteValue;
    FValue.ValueType := VALUE_TYPE4;
    New(FValue.Value4);
  end;
  
  FValue.Value4^.Value := AValue;
end;

procedure TVariant8{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7, T8>{$ENDIF}
  .SetValue (AValue : T5);
begin
  if FValue.ValueType <> VALUE_TYPE5 then
  begin
    DeleteValue;
    FValue.ValueType := VALUE_TYPE5;
    New(FValue.Value5);
  end;
  
  FValue.Value5^.Value := AValue;
end;

procedure TVariant8{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7, T8>{$ENDIF}
  .SetValue (AValue : T6);
begin
  if FValue.ValueType <> VALUE_TYPE6 then
  begin
    DeleteValue;
    FValue.ValueType := VALUE_TYPE6;
    New(FValue.Value6);
  end;
  
  FValue.Value6^.Value := AValue;
end;

procedure TVariant8{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7, T8>{$ENDIF}
  .SetValue (AValue : T7);
begin
  if FValue.ValueType <> VALUE_TYPE7 then
  begin
    DeleteValue;
    FValue.ValueType := VALUE_TYPE7;
    New(FValue.Value7);
  end;
  
  FValue.Value7^.Value := AValue;
end;

procedure TVariant8{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7, T8>{$ENDIF}
  .SetValue (AValue : T8);
begin
  if FValue.ValueType <> VALUE_TYPE8 then
  begin
    DeleteValue;
    FValue.ValueType := VALUE_TYPE8;
    New(FValue.Value8);
  end;
  
  FValue.Value8^.Value := AValue;
end;

{ TVariant9 }

constructor TVariant9{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7, T8, T9>{$ENDIF}
  .Create;
begin
  FValue.ValueType := VALUE_TYPE1;
  New(FValue.Value1);
  FValue.Value1^.Value := Default(T1);
end;

destructor TVariant9{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7, T8, T9>{$ENDIF}
  .Destroy;
begin
  DeleteValue;
  inherited Destroy;
end;

procedure TVariant9{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7, T8, T9>{$ENDIF}
  .DeleteValue;
begin
  case FValue.ValueType of
    VALUE_TYPE1 : begin
      Dispose(FValue.Value1);
    end;
    VALUE_TYPE2 : begin
      Dispose(FValue.Value2);
    end;
    VALUE_TYPE3 : begin
      Dispose(FValue.Value3);
    end;
    VALUE_TYPE4 : begin
      Dispose(FValue.Value4);
    end;
    VALUE_TYPE5 : begin
      Dispose(FValue.Value5);
    end;
    VALUE_TYPE6 : begin
      Dispose(FValue.Value6);
    end;
    VALUE_TYPE7 : begin
      Dispose(FValue.Value7);
    end;
    VALUE_TYPE8 : begin
      Dispose(FValue.Value8);
    end;
    VALUE_TYPE9 : begin
      Dispose(FValue.Value9);
    end;
  end;
end;

function TVariant9{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7, T8, T9>{$ENDIF}
  .GetType : TValueType;
begin
  Result := FValue.ValueType;
end;

function TVariant9{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7, T8, T9>{$ENDIF}
  .GetValue : TVariantValue;
begin
  case FValue.ValueType of
    VALUE_TYPE1 : begin
      Exit(TVariantValue1.Create(FValue.Value1^.Value));
    end;
    VALUE_TYPE2 : begin
      Exit(TVariantValue2.Create(FValue.Value2^.Value));
    end;
    VALUE_TYPE3 : begin
      Exit(TVariantValue3.Create(FValue.Value3^.Value));
    end;
    VALUE_TYPE4 : begin
      Exit(TVariantValue4.Create(FValue.Value4^.Value));
    end;
    VALUE_TYPE5 : begin
      Exit(TVariantValue5.Create(FValue.Value5^.Value));
    end;
    VALUE_TYPE6 : begin
      Exit(TVariantValue6.Create(FValue.Value6^.Value));
    end;
    VALUE_TYPE7 : begin
      Exit(TVariantValue7.Create(FValue.Value7^.Value));
    end;
    VALUE_TYPE8 : begin
      Exit(TVariantValue8.Create(FValue.Value8^.Value));
    end;
    VALUE_TYPE9 : begin
      Exit(TVariantValue9.Create(FValue.Value9^.Value));
    end;
  end;

  raise ETypeUndefinedException.Create('Variant udefined type.');
end;

procedure TVariant9{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7, T8, T9>{$ENDIF}
  .SetValue (AValue : T1);
begin
  if FValue.ValueType <> VALUE_TYPE1 then
  begin  
    DeleteValue;
    FValue.ValueType := VALUE_TYPE1;
    New(FValue.Value1);
  end;

  FValue.Value1^.Value := AValue;
end;

procedure TVariant9{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7, T8, T9>{$ENDIF}
  .SetValue (AValue : T2);
begin
  if FValue.ValueType <> VALUE_TYPE2 then
  begin
    DeleteValue;
    FValue.ValueType := VALUE_TYPE2;
    New(FValue.Value2);
  end;
  
  FValue.Value2^.Value := AValue;
end;

procedure TVariant9{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7, T8, T9>{$ENDIF}
  .SetValue (AValue : T3);
begin
  if FValue.ValueType <> VALUE_TYPE3 then
  begin
    DeleteValue;
    FValue.ValueType := VALUE_TYPE3;
    New(FValue.Value3);
  end;
  
  FValue.Value3^.Value := AValue;
end;

procedure TVariant9{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7, T8, T9>{$ENDIF}
  .SetValue (AValue : T4);
begin
  if FValue.ValueType <> VALUE_TYPE4 then
  begin
    DeleteValue;
    FValue.ValueType := VALUE_TYPE4;
    New(FValue.Value4);
  end;
  
  FValue.Value4^.Value := AValue;
end;

procedure TVariant9{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7, T8, T9>{$ENDIF}
  .SetValue (AValue : T5);
begin
  if FValue.ValueType <> VALUE_TYPE5 then
  begin
    DeleteValue;
    FValue.ValueType := VALUE_TYPE5;
    New(FValue.Value5);
  end;
  
  FValue.Value5^.Value := AValue;
end;

procedure TVariant9{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7, T8, T9>{$ENDIF}
  .SetValue (AValue : T6);
begin
  if FValue.ValueType <> VALUE_TYPE6 then
  begin
    DeleteValue;
    FValue.ValueType := VALUE_TYPE6;
    New(FValue.Value6);
  end;
  
  FValue.Value6^.Value := AValue;
end;

procedure TVariant9{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7, T8, T9>{$ENDIF}
  .SetValue (AValue : T7);
begin
  if FValue.ValueType <> VALUE_TYPE7 then
  begin
    DeleteValue;
    FValue.ValueType := VALUE_TYPE7;
    New(FValue.Value7);
  end;
  
  FValue.Value7^.Value := AValue;
end;

procedure TVariant9{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7, T8, T9>{$ENDIF}
  .SetValue (AValue : T8);
begin
  if FValue.ValueType <> VALUE_TYPE8 then
  begin
    DeleteValue;
    FValue.ValueType := VALUE_TYPE8;
    New(FValue.Value8);
  end;
  
  FValue.Value8^.Value := AValue;
end;

procedure TVariant9{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7, T8, T9>{$ENDIF}
  .SetValue (AValue : T9);
begin
  if FValue.ValueType <> VALUE_TYPE9 then
  begin
    DeleteValue;
    FValue.ValueType := VALUE_TYPE9;
    New(FValue.Value9);
  end;
  
  FValue.Value9^.Value := AValue;
end;

{ TVariant10 }

constructor TVariant10{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>
  {$ENDIF}.Create;
begin
  FValue.ValueType := VALUE_TYPE1;
  New(FValue.Value1);
  FValue.Value1^.Value := Default(T1);
end;

destructor TVariant10{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>
  {$ENDIF}.Destroy;
begin
  DeleteValue;
  inherited Destroy;
end;

procedure TVariant10{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>
  {$ENDIF}.DeleteValue;
begin
  case FValue.ValueType of
    VALUE_TYPE1 : begin
      Dispose(FValue.Value1);
    end;
    VALUE_TYPE2 : begin
      Dispose(FValue.Value2);
    end;
    VALUE_TYPE3 : begin
      Dispose(FValue.Value3);
    end;
    VALUE_TYPE4 : begin
      Dispose(FValue.Value4);
    end;
    VALUE_TYPE5 : begin
      Dispose(FValue.Value5);
    end;
    VALUE_TYPE6 : begin
      Dispose(FValue.Value6);
    end;
    VALUE_TYPE7 : begin
      Dispose(FValue.Value7);
    end;
    VALUE_TYPE8 : begin
      Dispose(FValue.Value8);
    end;
    VALUE_TYPE9 : begin
      Dispose(FValue.Value9);
    end;
    VALUE_TYPE10 : begin
      Dispose(FValue.Value10);
    end;
  end;
end;

function TVariant10{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>
  {$ENDIF}.GetType : TValueType;
begin
  Result := FValue.ValueType;
end;

function TVariant10{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>
  {$ENDIF}.GetValue : TVariantValue;
begin
  case FValue.ValueType of
    VALUE_TYPE1 : begin
      Exit(TVariantValue1.Create(FValue.Value1^.Value));
    end;
    VALUE_TYPE2 : begin
      Exit(TVariantValue2.Create(FValue.Value2^.Value));
    end;
    VALUE_TYPE3 : begin
      Exit(TVariantValue3.Create(FValue.Value3^.Value));
    end;
    VALUE_TYPE4 : begin
      Exit(TVariantValue4.Create(FValue.Value4^.Value));
    end;
    VALUE_TYPE5 : begin
      Exit(TVariantValue5.Create(FValue.Value5^.Value));
    end;
    VALUE_TYPE6 : begin
      Exit(TVariantValue6.Create(FValue.Value6^.Value));
    end;
    VALUE_TYPE7 : begin
      Exit(TVariantValue7.Create(FValue.Value7^.Value));
    end;
    VALUE_TYPE8 : begin
      Exit(TVariantValue8.Create(FValue.Value8^.Value));
    end;
    VALUE_TYPE9 : begin
      Exit(TVariantValue9.Create(FValue.Value9^.Value));
    end;
    VALUE_TYPE10 : begin
      Exit(TVariantValue10.Create(FValue.Value10^.Value));
    end;
  end;

  raise ETypeUndefinedException.Create('Variant udefined type.');
end;

procedure TVariant10{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>
  {$ENDIF}.SetValue (AValue : T1);
begin
  if FValue.ValueType <> VALUE_TYPE1 then
  begin  
    DeleteValue;
    FValue.ValueType := VALUE_TYPE1;
    New(FValue.Value1);
  end;

  FValue.Value1^.Value := AValue;
end;

procedure TVariant10{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>
  {$ENDIF}.SetValue (AValue : T2);
begin
  if FValue.ValueType <> VALUE_TYPE2 then
  begin
    DeleteValue;
    FValue.ValueType := VALUE_TYPE2;
    New(FValue.Value2);
  end;
  
  FValue.Value2^.Value := AValue;
end;

procedure TVariant10{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>
  {$ENDIF}.SetValue (AValue : T3);
begin
  if FValue.ValueType <> VALUE_TYPE3 then
  begin
    DeleteValue;
    FValue.ValueType := VALUE_TYPE3;
    New(FValue.Value3);
  end;
  
  FValue.Value3^.Value := AValue;
end;

procedure TVariant10{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>
  {$ENDIF}.SetValue (AValue : T4);
begin
  if FValue.ValueType <> VALUE_TYPE4 then
  begin
    DeleteValue;
    FValue.ValueType := VALUE_TYPE4;
    New(FValue.Value4);
  end;
  
  FValue.Value4^.Value := AValue;
end;

procedure TVariant10{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>
  {$ENDIF}.SetValue (AValue : T5);
begin
  if FValue.ValueType <> VALUE_TYPE5 then
  begin
    DeleteValue;
    FValue.ValueType := VALUE_TYPE5;
    New(FValue.Value5);
  end;
  
  FValue.Value5^.Value := AValue;
end;

procedure TVariant10{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>
  {$ENDIF}.SetValue (AValue : T6);
begin
  if FValue.ValueType <> VALUE_TYPE6 then
  begin
    DeleteValue;
    FValue.ValueType := VALUE_TYPE6;
    New(FValue.Value6);
  end;
  
  FValue.Value6^.Value := AValue;
end;

procedure TVariant10{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>
  {$ENDIF}.SetValue (AValue : T7);
begin
  if FValue.ValueType <> VALUE_TYPE7 then
  begin
    DeleteValue;
    FValue.ValueType := VALUE_TYPE7;
    New(FValue.Value7);
  end;
  
  FValue.Value7^.Value := AValue;
end;

procedure TVariant10{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>
  {$ENDIF}.SetValue (AValue : T8);
begin
  if FValue.ValueType <> VALUE_TYPE8 then
  begin
    DeleteValue;
    FValue.ValueType := VALUE_TYPE8;
    New(FValue.Value8);
  end;
  
  FValue.Value8^.Value := AValue;
end;

procedure TVariant10{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>
  {$ENDIF}.SetValue (AValue : T9);
begin
  if FValue.ValueType <> VALUE_TYPE9 then
  begin
    DeleteValue;
    FValue.ValueType := VALUE_TYPE9;
    New(FValue.Value9);
  end;
  
  FValue.Value9^.Value := AValue;
end;

procedure TVariant10{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>
  {$ENDIF}.SetValue (AValue : T10);
begin
  if FValue.ValueType <> VALUE_TYPE10 then
  begin
    DeleteValue;
    FValue.ValueType := VALUE_TYPE10;
    New(FValue.Value10);
  end;
  
  FValue.Value10^.Value := AValue;
end;

end.

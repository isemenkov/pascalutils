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

  {$IFDEF FPC}generic{$ENDIF} TVariant2<T1, T2> = class
  public
    type
      TValueType = (
        VALUE_TYPE1,
        VALUE_TYPE2
      );

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
      
      { Variant T1 data type. }
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

  raise Exception.Create('ErrorMessage');
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

end.

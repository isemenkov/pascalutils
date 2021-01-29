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

unit utils.tuple;

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
  { Contains tuple of values like in C++ language. }
  {$IFDEF FPC}generic{$ENDIF} TTuple3<T1, T2, T3> = class
  public
    type
      TSelfTuple3 = {$IFDEF FPC}specialize{$ENDIF} TTuple3<T1, T2, T3>;
  protected
    FFirst : T1;
    FSecond : T2;
    FThird : T3;
  public
    { Create tuple with default values of T1, T2 and T3 } 
    constructor Create; overload;

    { Create tuple with defined values. }
    constructor Create (AFirst : T1; ASecond : T2; AThird : T3); overload;

    { Create tuple from exiting pair. }
    constructor Create (ATuple : TSelfTuple3); overload;

    { Tuple first value. }
    property First : T1 read FFirst write FFirst;

    { Tuple second value. }
    property Second : T2 read FSecond write FSecond;

    { Tuple third value. }
    property Third : T3 read FThird write FThird;
  end;

  {$IFDEF FPC}generic{$ENDIF} TTuple4<T1, T2, T3, T4> = class
  public
    type
      TSelfTuple4 = {$IFDEF FPC}specialize{$ENDIF} TTuple4<T1, T2, T3, T4>;
  protected
    FFirst : T1;
    FSecond : T2;
    FThird : T3;
    FFourth : T4;
  public
    { Create tuple with default values of T1, T2, T3 and T4 } 
    constructor Create; overload;

    { Create tuple with defined values. }
    constructor Create (AFirst : T1; ASecond : T2; AThird : T3; AFourth : T4); 
      overload;

    { Create tuple from exiting pair. }
    constructor Create (ATuple : TSelfTuple4); overload;

    { Tuple first value. }
    property First : T1 read FFirst write FFirst;

    { Tuple second value. }
    property Second : T2 read FSecond write FSecond;

    { Tuple third value. }
    property Third : T3 read FThird write FThird;

    { Tuple fourth value. }
    property Fourth : T4 read FFourth write FFourth;
  end;

  {$IFDEF FPC}generic{$ENDIF} TTuple5<T1, T2, T3, T4, T5> = class
  public
    type
      TSelfTuple5 = {$IFDEF FPC}specialize{$ENDIF} TTuple5<T1, T2, T3, T4, T5>;
  protected
    FFirst : T1;
    FSecond : T2;
    FThird : T3;
    FFourth : T4;
    FFifth : T5;
  public
    { Create tuple with default values of T1, T2, T3, T4 and T5 } 
    constructor Create; overload;

    { Create tuple with defined values. }
    constructor Create (AFirst : T1; ASecond : T2; AThird : T3; AFourth : T4;
      AFifth : T5); overload;

    { Create tuple from exiting pair. }
    constructor Create (ATuple : TSelfTuple5); overload;

    { Tuple first value. }
    property First : T1 read FFirst write FFirst;

    { Tuple second value. }
    property Second : T2 read FSecond write FSecond;

    { Tuple third value. }
    property Third : T3 read FThird write FThird;

    { Tuple fourth value. }
    property Fourth : T4 read FFourth write FFourth;

    { Tuple fifth value. }
    property Fifth : T5 read FFifth write FFifth;
  end;

  {$IFDEF FPC}generic{$ENDIF} TTuple6<T1, T2, T3, T4, T5, T6> = class
  public
    type
      TSelfTuple6 = {$IFDEF FPC}specialize{$ENDIF} TTuple6<T1, T2, T3, T4, T5,
        T6>;
  protected
    FFirst : T1;
    FSecond : T2;
    FThird : T3;
    FFourth : T4;
    FFifth : T5;
    FSixth : T6;
  public
    { Create tuple with default values of T1, T2, T3, T4, T5 and T6 } 
    constructor Create; overload;

    { Create tuple with defined values. }
    constructor Create (AFirst : T1; ASecond : T2; AThird : T3; AFourth : T4;
      AFifth : T5; ASixth : T6); overload;

    { Create tuple from exiting pair. }
    constructor Create (ATuple : TSelfTuple6); overload;

    { Tuple first value. }
    property First : T1 read FFirst write FFirst;

    { Tuple second value. }
    property Second : T2 read FSecond write FSecond;

    { Tuple third value. }
    property Third : T3 read FThird write FThird;

    { Tuple fourth value. }
    property Fourth : T4 read FFourth write FFourth;

    { Tuple fifth value. }
    property Fifth : T5 read FFifth write FFifth;

    { Tuple sixth value. }
    property Sixth : T6 read FSixth write FSixth;
  end;

  {$IFDEF FPC}generic{$ENDIF} TTuple7<T1, T2, T3, T4, T5, T6, T7> = class
  public
    type
      TSelfTuple7 = {$IFDEF FPC}specialize{$ENDIF} TTuple7<T1, T2, T3, T4, T5,
        T6, T7>;
  protected
    FFirst : T1;
    FSecond : T2;
    FThird : T3;
    FFourth : T4;
    FFifth : T5;
    FSixth : T6;
    FSeventh : T7;
  public
    { Create tuple with default values of T1, T2, T3, T4, T5, T6 and T7 } 
    constructor Create; overload;

    { Create tuple with defined values. }
    constructor Create (AFirst : T1; ASecond : T2; AThird : T3; AFourth : T4;
      AFifth : T5; ASixth : T6; ASeventh : T7); overload;

    { Create tuple from exiting pair. }
    constructor Create (ATuple : TSelfTuple7); overload;

    { Tuple first value. }
    property First : T1 read FFirst write FFirst;

    { Tuple second value. }
    property Second : T2 read FSecond write FSecond;

    { Tuple third value. }
    property Third : T3 read FThird write FThird;

    { Tuple fourth value. }
    property Fourth : T4 read FFourth write FFourth;

    { Tuple fifth value. }
    property Fifth : T5 read FFifth write FFifth;

    { Tuple sixth value. }
    property Sixth : T6 read FSixth write FSixth;

    { Tuple seventh value. }
    property Seventh : T7 read FSeventh write FSeventh;
  end;

  {$IFDEF FPC}generic{$ENDIF} TTuple8<T1, T2, T3, T4, T5, T6, T7, T8> = class
  public
    type
      TSelfTuple8 = {$IFDEF FPC}specialize{$ENDIF} TTuple8<T1, T2, T3, T4, T5,
        T6, T7, T8>;
  protected
    FFirst : T1;
    FSecond : T2;
    FThird : T3;
    FFourth : T4;
    FFifth : T5;
    FSixth : T6;
    FSeventh : T7;
    FEighth : T8;
  public
    { Create tuple with default values of T1, T2, T3, T4, T5, T6, T7 and T8 } 
    constructor Create; overload;

    { Create tuple with defined values. }
    constructor Create (AFirst : T1; ASecond : T2; AThird : T3; AFourth : T4;
      AFifth : T5; ASixth : T6; ASeventh : T7; AEighth : T8); overload;

    { Create tuple from exiting pair. }
    constructor Create (ATuple : TSelfTuple8); overload;

    { Tuple first value. }
    property First : T1 read FFirst write FFirst;

    { Tuple second value. }
    property Second : T2 read FSecond write FSecond;

    { Tuple third value. }
    property Third : T3 read FThird write FThird;

    { Tuple fourth value. }
    property Fourth : T4 read FFourth write FFourth;

    { Tuple fifth value. }
    property Fifth : T5 read FFifth write FFifth;

    { Tuple sixth value. }
    property Sixth : T6 read FSixth write FSixth;

    { Tuple seventh value. }
    property Seventh : T7 read FSeventh write FSeventh;

    { Tuple eighth value. }
    property Eighth : T8 read FEighth write FEighth;
  end;

  {$IFDEF FPC}generic{$ENDIF} TTuple9<T1, T2, T3, T4, T5, T6, T7, T8, 
    T9> = class
  public
    type
      TSelfTuple9 = {$IFDEF FPC}specialize{$ENDIF} TTuple9<T1, T2, T3, T4, T5,
        T6, T7, T8, T9>;
  protected
    FFirst : T1;
    FSecond : T2;
    FThird : T3;
    FFourth : T4;
    FFifth : T5;
    FSixth : T6;
    FSeventh : T7;
    FEighth : T8;
    FNinth : T9;
  public
    { Create tuple with default values of T1, T2, T3, T4, T5, T6, T7, T8 
      and T9 } 
    constructor Create; overload;

    { Create tuple with defined values. }
    constructor Create (AFirst : T1; ASecond : T2; AThird : T3; AFourth : T4;
      AFifth : T5; ASixth : T6; ASeventh : T7; AEighth : T8; ANinth : T9); 
      overload;

    { Create tuple from exiting pair. }
    constructor Create (ATuple : TSelfTuple9); overload;

    { Tuple first value. }
    property First : T1 read FFirst write FFirst;

    { Tuple second value. }
    property Second : T2 read FSecond write FSecond;

    { Tuple third value. }
    property Third : T3 read FThird write FThird;

    { Tuple fourth value. }
    property Fourth : T4 read FFourth write FFourth;

    { Tuple fifth value. }
    property Fifth : T5 read FFifth write FFifth;

    { Tuple sixth value. }
    property Sixth : T6 read FSixth write FSixth;

    { Tuple seventh value. }
    property Seventh : T7 read FSeventh write FSeventh;

    { Tuple eighth value. }
    property Eighth : T8 read FEighth write FEighth;

    { Tuple ninth value. }
    property Ninth : T9 read FNinth write FNinth;
  end;

  {$IFDEF FPC}generic{$ENDIF} TTuple10<T1, T2, T3, T4, T5, T6, T7, T8, 
    T9, T10> = class
  public
    type
      TSelfTuple10 = {$IFDEF FPC}specialize{$ENDIF} TTuple10<T1, T2, T3, T4, T5,
        T6, T7, T8, T9, T10>;
  protected
    FFirst : T1;
    FSecond : T2;
    FThird : T3;
    FFourth : T4;
    FFifth : T5;
    FSixth : T6;
    FSeventh : T7;
    FEighth : T8;
    FNinth : T9;
    FTenth : T10;
  public
    { Create tuple with default values of T1, T2, T3, T4, T5, T6, T7, T8, T9
      and T10 } 
    constructor Create; overload;

    { Create tuple with defined values. }
    constructor Create (AFirst : T1; ASecond : T2; AThird : T3; AFourth : T4;
      AFifth : T5; ASixth : T6; ASeventh : T7; AEighth : T8; ANinth : T9;
      ATenth : T10); 
      overload;

    { Create tuple from exiting pair. }
    constructor Create (ATuple : TSelfTuple10); overload;

    { Tuple first value. }
    property First : T1 read FFirst write FFirst;

    { Tuple second value. }
    property Second : T2 read FSecond write FSecond;

    { Tuple third value. }
    property Third : T3 read FThird write FThird;

    { Tuple fourth value. }
    property Fourth : T4 read FFourth write FFourth;

    { Tuple fifth value. }
    property Fifth : T5 read FFifth write FFifth;

    { Tuple sixth value. }
    property Sixth : T6 read FSixth write FSixth;

    { Tuple seventh value. }
    property Seventh : T7 read FSeventh write FSeventh;

    { Tuple eighth value. }
    property Eighth : T8 read FEighth write FEighth;

    { Tuple ninth value. }
    property Ninth : T9 read FNinth write FNinth;

    { Tuple tenth value. }
    property Tenth : T10 read FTenth write FTenth;
  end;

implementation

{ TTuple3 generic }

constructor TTuple3{$IFNDEF FPC}<T1, T2, T3>{$ENDIF}.Create;
begin
  FFirst := Default(T1);
  FSecond := Default(T2);
  FThird := Default(T3);
  inherited Create;
end;

constructor TTuple3{$IFNDEF FPC}<T1, T2, T3>{$ENDIF}.Create (AFirst : T1; 
  ASecond : T2; AThird : T3);
begin
  FFirst := AFirst;
  FSecond := ASecond;
  FThird := AThird;
end;

constructor TTuple3{$IFNDEF FPC}<T1, T2, T3>{$ENDIF}.Create (ATuple : 
  TSelfTuple3);
begin
  FFirst := ATuple.First;
  FSecond := ATuple.Second;
  FThird := ATuple.Third;
end;

{ TTuple4 generic }

constructor TTuple4{$IFNDEF FPC}<T1, T2, T3, T4>{$ENDIF}.Create;
begin
  FFirst := Default(T1);
  FSecond := Default(T2);
  FThird := Default(T3);
  FFourth := Default(T4);
  inherited Create;
end;

constructor TTuple4{$IFNDEF FPC}<T1, T2, T3, T4>{$ENDIF}.Create (AFirst : T1; 
  ASecond : T2; AThird : T3; AFourth : T4);
begin
  FFirst := AFirst;
  FSecond := ASecond;
  FThird := AThird;
  FFourth := AFourth;
end;

constructor TTuple4{$IFNDEF FPC}<T1, T2, T3, T4>{$ENDIF}.Create (ATuple : 
  TSelfTuple4);
begin
  FFirst := ATuple.First;
  FSecond := ATuple.Second;
  FThird := ATuple.Third;
  FFourth := ATuple.Fourth;
end;

{ TTuple5 generic }

constructor TTuple5{$IFNDEF FPC}<T1, T2, T3, T4, T5>{$ENDIF}.Create;
begin
  FFirst := Default(T1);
  FSecond := Default(T2);
  FThird := Default(T3);
  FFourth := Default(T4);
  FFifth := Default(T5);
  inherited Create;
end;

constructor TTuple5{$IFNDEF FPC}<T1, T2, T3, T4, T5>{$ENDIF}.Create (AFirst : 
  T1; ASecond : T2; AThird : T3; AFourth : T4; AFifth : T5);
begin
  FFirst := AFirst;
  FSecond := ASecond;
  FThird := AThird;
  FFourth := AFourth;
  FFifth := AFifth;
end;

constructor TTuple5{$IFNDEF FPC}<T1, T2, T3, T4, T5>{$ENDIF}.Create (ATuple : 
  TSelfTuple5);
begin
  FFirst := ATuple.First;
  FSecond := ATuple.Second;
  FThird := ATuple.Third;
  FFourth := ATuple.Fourth;
  FFifth := ATuple.Fifth;
end;

{ TTuple6 generic }

constructor TTuple6{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6>{$ENDIF}.Create;
begin
  FFirst := Default(T1);
  FSecond := Default(T2);
  FThird := Default(T3);
  FFourth := Default(T4);
  FFifth := Default(T5);
  FSixth := Default(T6);
  inherited Create;
end;

constructor TTuple6{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6>{$ENDIF}
  .Create (AFirst : T1; ASecond : T2; AThird : T3; AFourth : T4; AFifth : T5;
  ASixth : T6);
begin
  FFirst := AFirst;
  FSecond := ASecond;
  FThird := AThird;
  FFourth := AFourth;
  FFifth := AFifth;
  FSixth := ASixth;
end;

constructor TTuple6{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6>{$ENDIF}
  .Create (ATuple : TSelfTuple6);
begin
  FFirst := ATuple.First;
  FSecond := ATuple.Second;
  FThird := ATuple.Third;
  FFourth := ATuple.Fourth;
  FFifth := ATuple.Fifth;
  FSixth := ATuple.Sixth;
end;

{ TTuple7 generic }

constructor TTuple7{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7>{$ENDIF}.Create;
begin
  FFirst := Default(T1);
  FSecond := Default(T2);
  FThird := Default(T3);
  FFourth := Default(T4);
  FFifth := Default(T5);
  FSixth := Default(T6);
  FSeventh := Default(T7);
  inherited Create;
end;

constructor TTuple7{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7>{$ENDIF}
  .Create (AFirst : T1; ASecond : T2; AThird : T3; AFourth : T4; AFifth : T5;
  ASixth : T6; ASeventh : T7);
begin
  FFirst := AFirst;
  FSecond := ASecond;
  FThird := AThird;
  FFourth := AFourth;
  FFifth := AFifth;
  FSixth := ASixth;
  FSeventh := ASeventh;
end;

constructor TTuple7{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7>{$ENDIF}
  .Create (ATuple : TSelfTuple7);
begin
  FFirst := ATuple.First;
  FSecond := ATuple.Second;
  FThird := ATuple.Third;
  FFourth := ATuple.Fourth;
  FFifth := ATuple.Fifth;
  FSixth := ATuple.Sixth;
  FSeventh := ATuple.Seventh;
end;

{ TTuple8 generic }

constructor TTuple8{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7, T8>{$ENDIF}.Create;
begin
  FFirst := Default(T1);
  FSecond := Default(T2);
  FThird := Default(T3);
  FFourth := Default(T4);
  FFifth := Default(T5);
  FSixth := Default(T6);
  FSeventh := Default(T7);
  FEighth := Default(T8);
  inherited Create;
end;

constructor TTuple8{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7, T8>{$ENDIF}
  .Create (AFirst : T1; ASecond : T2; AThird : T3; AFourth : T4; AFifth : T5;
  ASixth : T6; ASeventh : T7; AEighth : T8);
begin
  FFirst := AFirst;
  FSecond := ASecond;
  FThird := AThird;
  FFourth := AFourth;
  FFifth := AFifth;
  FSixth := ASixth;
  FSeventh := ASeventh;
  FEighth := AEighth;
end;

constructor TTuple8{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7, T8>{$ENDIF}
  .Create (ATuple : TSelfTuple8);
begin
  FFirst := ATuple.First;
  FSecond := ATuple.Second;
  FThird := ATuple.Third;
  FFourth := ATuple.Fourth;
  FFifth := ATuple.Fifth;
  FSixth := ATuple.Sixth;
  FSeventh := ATuple.Seventh;
  FEighth := ATuple.Eighth;
end;

{ TTuple9 generic }

constructor TTuple9{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7, T8, T9>{$ENDIF}
  .Create;
begin
  FFirst := Default(T1);
  FSecond := Default(T2);
  FThird := Default(T3);
  FFourth := Default(T4);
  FFifth := Default(T5);
  FSixth := Default(T6);
  FSeventh := Default(T7);
  FEighth := Default(T8);
  FNinth := Default(T9);
  inherited Create;
end;

constructor TTuple9{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7, T8, T9>{$ENDIF}
  .Create (AFirst : T1; ASecond : T2; AThird : T3; AFourth : T4; AFifth : T5;
  ASixth : T6; ASeventh : T7; AEighth : T8; ANinth : T9);
begin
  FFirst := AFirst;
  FSecond := ASecond;
  FThird := AThird;
  FFourth := AFourth;
  FFifth := AFifth;
  FSixth := ASixth;
  FSeventh := ASeventh;
  FEighth := AEighth;
  FNinth := ANinth;
end;

constructor TTuple9{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7, T8, T9>{$ENDIF}
  .Create (ATuple : TSelfTuple9);
begin
  FFirst := ATuple.First;
  FSecond := ATuple.Second;
  FThird := ATuple.Third;
  FFourth := ATuple.Fourth;
  FFifth := ATuple.Fifth;
  FSixth := ATuple.Sixth;
  FSeventh := ATuple.Seventh;
  FEighth := ATuple.Eighth;
  FNinth := ATuple.Ninth;
end;

{ TTuple10 generic }

constructor TTuple10{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7, T8, T9, 
  T10>{$ENDIF}.Create;
begin
  FFirst := Default(T1);
  FSecond := Default(T2);
  FThird := Default(T3);
  FFourth := Default(T4);
  FFifth := Default(T5);
  FSixth := Default(T6);
  FSeventh := Default(T7);
  FEighth := Default(T8);
  FNinth := Default(T9);
  FTenth := Default(T10);
  inherited Create;
end;

constructor TTuple10{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7, T8, T9, 
  T10>{$ENDIF}.Create (AFirst : T1; ASecond : T2; AThird : T3; AFourth : T4; 
  AFifth : T5; ASixth : T6; ASeventh : T7; AEighth : T8; ANinth : T9; 
  ATenth : T10);
begin
  FFirst := AFirst;
  FSecond := ASecond;
  FThird := AThird;
  FFourth := AFourth;
  FFifth := AFifth;
  FSixth := ASixth;
  FSeventh := ASeventh;
  FEighth := AEighth;
  FNinth := ANinth;
  FTenth := ATenth;
end;

constructor TTuple10{$IFNDEF FPC}<T1, T2, T3, T4, T5, T6, T7, T8, T9,
  T10>{$ENDIF}.Create (ATuple : TSelfTuple10);
begin
  FFirst := ATuple.First;
  FSecond := ATuple.Second;
  FThird := ATuple.Third;
  FFourth := ATuple.Fourth;
  FFifth := ATuple.Fifth;
  FSixth := ATuple.Sixth;
  FSeventh := ATuple.Seventh;
  FEighth := ATuple.Eighth;
  FNinth := ATuple.Ninth;
  FTenth := ATuple.Tenth;
end;

end.
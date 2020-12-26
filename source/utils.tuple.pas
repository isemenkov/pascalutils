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

end.
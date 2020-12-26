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

unit utils.pair;

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
  { Contains pair of values like in C++ language. }
  {$IFDEF FPC}generic{$ENDIF} TPair<T1, T2> = class
  public
    type
      TSelfPair = {$IFDEF FPC}specialize{$ENDIF} TPair<T1, T2>;
  protected
    FFirst : T1;
    FSecond : T2;
  public
    { Create pair with default values of T1 and T2 } 
    constructor Create; overload;

    { Create pair with defined values. }
    constructor Create (AFirst : T1; ASecond : T2); overload;

    { Create pair from exiting pair. }
    constructor Create (APair : TSelfPair); overload;

    { Pair first value. }
    property First : T1 read FFirst write FFirst;

    { Pair second value. }
    property Second : T2 read FSecond write FSecond;
  end;

implementation

{ TPair generic }

constructor TPair{$IFNDEF FPC}<T1, T2>{$ENDIF}.Create;
begin
  FFirst := Default(T1);
  FSecond := Default(T2);
  inherited Create;
end;

constructor TPair{$IFNDEF FPC}<T1, T2>{$ENDIF}.Create (AFirst : T1; ASecond :
  T2);
begin
  FFirst := AFirst;
  FSecond := ASecond;
end;

constructor TPair{$IFNDEF FPC}<T1, T2>{$ENDIF}.Create (APair : TSelfPair);
begin
  FFirst := APair.First;
  FSecond := APair.Second;
end;

end.
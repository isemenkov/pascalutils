(******************************************************************************)
(*                                PascalUtils                                 *)
(*          delphi and object pascal library of utils data structures         *)
(*                                                                            *)
(* Copyright (c) 2020                                       Ivan Semenkov     *)
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
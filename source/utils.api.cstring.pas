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

unit utils.api.cstring;

{$IFDEF FPC}
  {$mode objfpc}{$H+}
{$ENDIF}
{$IFOPT D+}
  {$DEFINE DEBUG}
{$ENDIF}

interface

uses
  SysUtils {$IFNDEF FPC}, System.AnsiStrings{$ENDIF};

type
  API = class
  public
    type
      CString = class
      public
        constructor Create; overload;
        constructor Create (AString : String); overload;
        constructor Create (AString : PAnsiChar); overload;

        function ToString : String; override;
        function ToPAnsiChar : PAnsiChar;
        function ToUniquePAnsiChar : PAnsiChar;
        function Length : Integer; 
      protected
        FString : String; 
      end;
  end;

implementation

{ API.CString }

constructor API.CString.Create;
begin
  FString := '';
end;

constructor API.CString.Create (AString : String);
begin
  FString := AString;
end;

constructor API.CString.Create (AString : PAnsiChar);
begin
  FString := String(Utf8ToString(AString));
end;

function API.CString.toString : String;
begin
  Result := FString;
end;

function API.CString.ToPAnsiChar : PAnsiChar;
begin
  Result := PAnsiChar({$IFNDEF FPC}Utf8Encode{$ENDIF}(FString));
end;

function API.CString.ToUniquePAnsiChar : PAnsiChar;
begin
  Result := {$IFNDEF FPC}System.AnsiStrings.{$ENDIF}StrNew(ToPAnsiChar);
end;

function API.CString.Length : Integer;
begin
  Result := System.Length(FString);
end;

end.

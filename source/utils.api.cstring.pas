(******************************************************************************)
(*                                PascalUtils                                 *)
(*          delphi and object pascal library of utils data structures         *)
(*                                                                            *)
(* Copyright (c) 2021                                       Ivan Semenkov     *)
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
      PAnsiStringWrapper = class
      public
        constructor Create (AString : PAnsiChar; ALength : Cardinal);
        destructor Destroy; override;
      protected
        FAnsiString : PAnsiChar;
        FLength : Cardinal;
      public
        property Value : PAnsiChar read FAnsiString;
        property Length : Cardinal read FLength;
      end;
      
      CString = class
      public
        constructor Create; overload;
        constructor Create (AString : String); overload;
        constructor Create (AString : PAnsiChar); overload;

        function ToString : String; override;
        function ToPAnsiChar : PAnsiChar;
        function ToUniquePAnsiChar : PAnsiStringWrapper;
        function Length : Integer; 
      protected
        FString : String;
      end;
  end;

implementation

{ API.PAnsiStringWrapper }

constructor API.PAnsiStringWrapper.Create (AString : PAnsiChar; ALength :
  Cardinal);
begin
  FAnsiString := AString;
  FLength := ALength;
end;

destructor API.PAnsiStringWrapper.Destroy;
begin
  {$IFNDEF FPC}System.AnsiStrings.{$ENDIF}StrDispose(FAnsiString);
end;

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

function API.CString.ToString : String;
begin
  Result := FString;
end;

function API.CString.ToPAnsiChar : PAnsiChar;
begin
  Result := PAnsiChar({$IFNDEF FPC}Utf8Encode{$ENDIF}(FString));
end;

function API.CString.ToUniquePAnsiChar : PAnsiStringWrapper;
begin
  Result := PAnsiStringWrapper.Create(
    {$IFNDEF FPC}System.AnsiStrings.{$ENDIF}StrNew(ToPAnsiChar),
    System.Length(FString)  
  );
end;

function API.CString.Length : Integer;
begin
  Result := System.Length(FString);
end;

end.

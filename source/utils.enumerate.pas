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

unit utils.enumerate;

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
  { Class adds counter to an iterable and returns it (the enumerate object) like
    in a Python language. }
  {$IFDEF FPC}generic{$ENDIF} TEnumerate<Iterator> = class
  protected
    type
      TIterator = class
      protected  
        { Return enumerator for in operator. }
        function GetEnumerator : TIterator;

        { Get current iterator. }
        function GetCurrent : TIterator;

        { Get current index. }
        function GetIndex : Integer; 
          {$IFDEF DEBUG}inline;{$ENDIF}

        { Get current iterator. }
        function GetValue : Iterator;
          {$IFDEF DEBUG}inline;{$ENDIF}
      public
        constructor Create (AStartIterator : Iterator; AStart : Integer);

        { Return True if can move to next item. }
        function MoveNext : Boolean;

        { Return current item and move pointer to next item. }
        property Current : TIterator read GetCurrent;

        { Return current iterable object index. }
        property Index : Integer read GetIndex;

        { Return current iterable object iterator. }
        property Value : Iterator read GetValue;
      protected
        FIterator : Iterator;
        FIndex : Integer;
      end;
  public
    constructor Create (AIterableObject : Iterator; AStart : Integer = 0);
    
    { Return enumerator for in operator. }
    function GetEnumerator : TIterator;
  protected
    FIterableObject : Iterator;
    FStartIndex : Integer;
  end;

implementation

{ TEnumerate.TIterator }

constructor TEnumerate{$IFNDEF FPC}<Iterator>{$ENDIF}.TIterator.Create(
  AStartIterator : Iterator; AStart : Integer);
begin
  FIterator := AStartIterator;
  FIndex := AStart;
end;

function TEnumerate{$IFNDEF FPC}<Iterator>{$ENDIF}.TIterator.GetIndex :
  Integer;
begin
  Result := FIndex;
end;

function TEnumerate{$IFNDEF FPC}<Iterator>{$ENDIF}.TIterator.GetValue :
  Iterator;
begin
  Result := FIterator;
end;

function TEnumerate{$IFNDEF FPC}<Iterator>{$ENDIF}.TIterator.GetEnumerator :
  TIterator;
begin
  Result := TIterator.Create(FIterator, FIndex);
end;

function TEnumerate{$IFNDEF FPC}<Iterator>{$ENDIF}.TIterator.MoveNext :
  Boolean;
begin
  Result := FIterator.MoveNext;
end;

function TEnumerate{$IFNDEF FPC}<Iterator>{$ENDIF}.TIterator.GetCurrent :
  TIterator;
begin
  Result := TIterator.Create(FIterator.GetCurrent, FIndex + 1);
  Inc(FIndex);
end;

{ TEnumerate }

constructor TEnumerate{$IFNDEF FPC}<Iterator>{$ENDIF}.Create (AIterableObject : 
  Iterator; AStart : Integer);
begin
  FIterableObject := AIterableObject;
  FStartIndex := AStart;
end;

function TEnumerate{$IFNDEF FPC}<Iterator>{$ENDIF}.GetEnumerator : TIterator;
begin
  Result := TIterator.Create(FIterableObject, FStartIndex);
end;

end.
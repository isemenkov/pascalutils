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
  { Common forward iterator. }
  {$IFDEF FPC}generic{$ENDIF} TForwardIterator<V> = class
  public
    { Return true if iterator has correct value. }
    function HasValue : Boolean; virtual; abstract;

    { Retrieve the next entry. }
    function Next : TForwardIterator{$IFNDEF FPC}<V>{$ENDIF}; virtual; abstract;

    { Return True if we can move to next element. }
    function MoveNext : Boolean; virtual; abstract;

    { Return enumerator for in operator. }
    function GetEnumerator : TForwardIterator{$IFNDEF FPC}<V>{$ENDIF}; virtual;
      abstract;
  protected
    { Get item value. }
    function GetValue : {$IFNDEF USE_OPTIONAL}V{$ELSE}TOptionalValue
      {$ENDIF}; virtual; abstract;

    { Return current item iterator and move it to next. }
    function GetCurrent : {$IFNDEF USE_OPTIONAL}V{$ELSE}TOptionalValue
      {$ENDIF}; virtual; abstract;
  public
    property Current : {$IFNDEF USE_OPTIONAL}V{$ELSE}TOptionalValue{$ENDIF}
      read GetCurrent;
  end;

  { Common bidirectional iterator. }
  {$IFDEF FPC}generic{$ENDIF} TBidirectionalIterator<V> = class
    ({$IFDEF FPC}specialize{$ENDIF} TForwardIterator<V>)
  public
    { Retrieve the previous entry. }
    function Prev : TBidirectionalIterator{$IFNDEF FPC}<V>{$ENDIF}; virtual;
      abstract;
  end;

  { Class adds counter to an iterable and returns it (the enumerate object) like
    in a Python language. }
  {$IFDEF FPC}generic{$ENDIF} TEnumerator<V> = class
  public
    type
      TCommonIterator = {$IFDEF FPC}specialize{$ENDIF} TForwardIterator<V>;
  protected
    type  
      TIterator = class(TCommonIterator)
      public
        constructor Create (AIterator : TCommonIterator; AIndex : Integer);

        { Return true if iterator has correct value. }
        function HasValue : Boolean; override;

        { Retrieve the next entry. }
        function Next : TIterator; reintroduce;

        { Return True if we can move to next element. }
        function MoveNext : Boolean; override;

        { Return enumerator for in operator. }
        function GetEnumerator : TIterator; reintroduce;
      protected
        { Get item value. }
        function GetValue : {$IFNDEF USE_OPTIONAL}V{$ELSE}TOptionalValue
          {$ENDIF}; override;

        { Return current item iterator and move it to next. }
        function GetCurrent : {$IFNDEF USE_OPTIONAL}TIterator{$ELSE}
          TOptionalValue{$ENDIF}; reintroduce;

        { Return current item index. }
        function GetIndex : Integer;
          {$IFDEF DEBUG}inline;{$ENDIF}
      public
        property Index : Integer read GetIndex;
      protected
        FInnerIterator : TCommonIterator;
        FIndex : Integer;
      end;
  public
    constructor Create (AIterator : TCommonIterator; AStartIndex : Integer = 0);

    { Return True if we can move to next element. }
    function MoveNext : Boolean;

    { Return enumerator for in operator. }
    function GetEnumerator : TIterator;
  protected
    { Return current item iterator and move it to next. }
    function GetCurrent : TIterator;
  public
    property Current : TIterator read GetCurrent;
  protected
    FIterator : TIterator; 
  end;

implementation

{ TEnumerator.TIterator }

constructor TEnumerator{$IFNDEF FPC}<V>{$ENDIF}.TIterator.Create (AIterator :
  TCommonIterator; AIndex : Integer);
begin
  FInnerIterator := AIterator;
  FIndex := AIndex;
end;

function TEnumerator{$IFNDEF FPC}<V>{$ENDIF}.TIterator.HasValue : Boolean;
begin
  Result := FInnerIterator.HasValue;
end;

function TEnumerator{$IFNDEF FPC}<V>{$ENDIF}.TIterator.Next : TIterator;
begin
  Result := TIterator.Create(FInnerIterator.Next, FIndex + 1);
end;

function TEnumerator{$IFNDEF FPC}<V>{$ENDIF}.TIterator.MoveNext : Boolean;
begin
  Result := FInnerIterator.HasValue;
end;

function TEnumerator{$IFNDEF FPC}<V>{$ENDIF}.TIterator.GetEnumerator : 
  TIterator;
begin
  Result := TIterator.Create(FInnerIterator, FIndex);
end;

function TEnumerator{$IFNDEF FPC}<V>{$ENDIF}.TIterator.GetValue : 
  {$IFNDEF USE_OPTIONAL}V{$ELSE}TOptionalValue{$ENDIF};
begin
  Result := FInnerIterator.GetValue;
end;

function TEnumerator{$IFNDEF FPC}<V>{$ENDIF}.TIterator.GetCurrent : 
  {$IFNDEF USE_OPTIONAL}TIterator{$ELSE}TOptionalValue{$ENDIF};
begin
  Result := TIterator.Create(FInnerIterator, FIndex);
  FInnerIterator := FInnerIterator.Next;
  Inc(FIndex);
end;

function TEnumerator{$IFNDEF FPC}<V>{$ENDIF}.TIterator.GetIndex : Integer;
begin
  Result := FIndex;
end;

{ TEnumerator }

constructor TEnumerator{$IFNDEF FPC}<V>{$ENDIF}.Create (AIterator : 
  TCommonIterator; AStartIndex : Integer);
begin
  FIterator := TIterator.Create(AIterator, AStartIndex);
end;

function TEnumerator{$IFNDEF FPC}<V>{$ENDIF}.MoveNext : Boolean;
begin
  Result := FIterator.MoveNext;
end;

function TEnumerator{$IFNDEF FPC}<V>{$ENDIF}.GetEnumerator : TIterator;
begin
  Result := FIterator;
  FIterator := FIterator.Next;
end;

function TEnumerator{$IFNDEF FPC}<V>{$ENDIF}.GetCurrent : TIterator;
begin
  Result := FIterator;
end;

end.

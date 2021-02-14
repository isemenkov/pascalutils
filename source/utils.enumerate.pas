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

unit utils.enumerate;

{$IFDEF FPC}
  {$mode objfpc}{$H+}
{$ENDIF}
{$IFOPT D+}
  {$DEFINE DEBUG}
{$ENDIF}

interface

uses
  SysUtils{$IFDEF USE_OPTIONAL}, utils.optional{$ENDIF}
  {$IFNDEF FPC}, utils.functor{$ENDIF};

type
  { Common forward iterator. }
  {$IFDEF FPC}generic{$ENDIF} TForwardIterator<V, Iterator> = class
  public
    type
      {$IFDEF USE_OPTIONAL}
      TOptionalValue = {$IFDEF FPC}specialize{$ENDIF} TOptional<V>;
      {$ENDIF}
  public
    { Return true if iterator has correct value. }
    function HasValue : Boolean; virtual; abstract;

    { Retrieve the next entry. }
    function Next : Iterator; 
      virtual; abstract;

    { Return True if we can move to next element. }
    function MoveNext : Boolean; virtual; abstract;

    { Return enumerator for in operator. }
    function GetEnumerator : Iterator; virtual; abstract;
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
  {$IFDEF FPC}generic{$ENDIF} TBidirectionalIterator<V, Iterator> = class 
    ({$IFDEF FPC}specialize{$ENDIF} TForwardIterator<V, Iterator>)
  public
    { Retrieve the previous entry. }
    function Prev : Iterator;
      virtual; abstract;
  end;

  { Class adds counter to an iterable and returns it (the enumerate object) like
    in a Python language. }
  {$IFDEF FPC}generic{$ENDIF} TEnumerator<V; Iterator
    {$IFNDEF FPC}: TForwardIterator<V, Iterator>{$ENDIF}> = class
  public
    type
      {$IFDEF USE_OPTIONAL}
      TOptionalValue = {$IFDEF FPC}specialize{$ENDIF} TOptional<V>;
      {$ENDIF}

      TIterator = class; { Fix for FreePascal compiler. }
      TIterator = class ({$IFDEF FPC}specialize{$ENDIF} TForwardIterator<V,
        TIterator>)
      protected
        constructor Create (AIterator : Iterator; AIndex : Integer);
      public
        { Return true if iterator has correct value. }
        function HasValue : Boolean; override;

        { Retrieve the next entry. }
        function Next : TIterator; override;

        { Return True if we can move to next element. }
        function MoveNext : Boolean; override;

        { Return enumerator for in operator. }
        function GetEnumerator : TIterator; override;
      protected
        { Get item value. }
        function GetValue : {$IFNDEF USE_OPTIONAL}V{$ELSE}TOptionalValue
          {$ENDIF}; override;

        { Return current item iterator and move it to next. }
        function GetCurrent : TIterator; reintroduce;

        { Return current item index. }
        function GetIndex : Integer;
          {$IFDEF DEBUG}inline;{$ENDIF}
      public
        property Index : Integer read GetIndex;
        property Value : {$IFNDEF USE_OPTIONAL}V{$ELSE}TOptionalValue
          {$ENDIF} read GetValue;

        property Current : TIterator read GetCurrent;
      protected
        FInnerIterator : Iterator;
        FIndex : Integer;
      end;
  public
    constructor Create (AIterator : Iterator; AStartIndex : Integer = 0);

    { Return True if we can move to next element. }
    function MoveNext : Boolean;

    { Retrive the first entry. }
    function FirstEntry : TIterator;
      {$IFNDEF DEBUG}inline;{$ENDIF}

    { Return enumerator for in operator. }
    function GetEnumerator : TIterator;
      {$IFNDEF DEBUG}inline;{$ENDIF}
  protected
    { Return current item iterator and move it to next. }
    function GetCurrent : TIterator;
  public
    property Current : TIterator read GetCurrent;
  protected
    FStartIndex : Integer;
    FBaseIterator : Iterator;
    FIterator : TIterator; 
  end;

  { Create filtering enumerator to an iterable object. }
  {$IFDEF FPC}generic{$ENDIF} TFilterEnumerator<V; Iterator
    {$IFNDEF FPC}: TForwardIterator<V, Iterator>{$ENDIF}; 
    Functor{$IFNDEF FPC}: TUnaryFunctor<V, Boolean>{$ENDIF}> = class
  public
    type
      {$IFDEF USE_OPTIONAL}
      TOptionalValue = {$IFDEF FPC}specialize{$ENDIF} TOptional<V>;
      {$ENDIF}

      TIterator = class; { Fix for FreePascal compiler. }
      TIterator = class ({$IFDEF FPC}specialize{$ENDIF} TForwardIterator<V,
        TIterator>)
      protected
        constructor Create (AIterator : Iterator; AFilter : Functor);
      public
        { Return true if iterator has correct value. }
        function HasValue : Boolean; override;

        { Retrieve the next entry. }
        function Next : TIterator; override;

        { Return True if we can move to next element. }
        function MoveNext : Boolean; override;

        { Return enumerator for in operator. }
        function GetEnumerator : TIterator; override;
      protected
        { Get item value. }
        function GetValue : {$IFNDEF USE_OPTIONAL}V{$ELSE}TOptionalValue
          {$ENDIF}; override;

        { Return current item iterator and move it to next. }
        function GetCurrent : TIterator; reintroduce;
      public
        property Value : {$IFNDEF USE_OPTIONAL}V{$ELSE}TOptionalValue
          {$ENDIF} read GetValue;

        property Current : TIterator read GetCurrent;
      protected
        FInnerIterator : Iterator;
        FFunctor : Functor;
      end;
  public
    constructor Create (AIterator : Iterator; AFilter : Functor);

    { Return True if we can move to next element. }
    function MoveNext : Boolean;

    { Retrive the first entry. }
    function FirstEntry : TIterator;
      {$IFNDEF DEBUG}inline;{$ENDIF}

    { Return enumerator for in operator. }
    function GetEnumerator : TIterator;
      {$IFNDEF DEBUG}inline;{$ENDIF}
  protected
    { Return current item iterator and move it to next. }
    function GetCurrent : TIterator;
  public
    property Current : TIterator read GetCurrent;
  protected
    FBaseIterator : Iterator;
    FIterator : TIterator; 
    FFunctor : Functor;
  end;

implementation

{ TEnumerator.TIterator }

constructor TEnumerator{$IFNDEF FPC}<V, Iterator>{$ENDIF}.TIterator.Create 
  (AIterator : Iterator; AIndex : Integer);
begin
  FInnerIterator := AIterator;
  FIndex := AIndex;
end;

function TEnumerator{$IFNDEF FPC}<V, Iterator>{$ENDIF}.TIterator.HasValue : 
  Boolean;
begin
  Result := FInnerIterator.HasValue;
end;

function TEnumerator{$IFNDEF FPC}<V, Iterator>{$ENDIF}.TIterator.Next : 
  TIterator;
begin
  Result := TIterator.Create(Iterator(FInnerIterator.Next), FIndex + 1);
end;

function TEnumerator{$IFNDEF FPC}<V, Iterator>{$ENDIF}.TIterator.MoveNext : 
  Boolean;
begin
  Result := FInnerIterator.HasValue;
end;

function TEnumerator{$IFNDEF FPC}<V, Iterator>{$ENDIF}.TIterator.GetEnumerator :
  TIterator;
begin
  Result := TIterator.Create(FInnerIterator, FIndex);
end;

function TEnumerator{$IFNDEF FPC}<V, Iterator>{$ENDIF}.TIterator.GetValue : 
  {$IFNDEF USE_OPTIONAL}V{$ELSE}TOptionalValue{$ENDIF};
begin
  Result := FInnerIterator.GetValue;
end;

function TEnumerator{$IFNDEF FPC}<V, Iterator>{$ENDIF}.TIterator.GetCurrent : 
  TIterator;
begin
  Result := TIterator.Create(FInnerIterator, FIndex);
  FInnerIterator := Iterator(FInnerIterator.Next);
  Inc(FIndex);
end;

function TEnumerator{$IFNDEF FPC}<V, Iterator>{$ENDIF}.TIterator.GetIndex : 
  Integer;
begin
  Result := FIndex;
end;

{ TEnumerator }

constructor TEnumerator{$IFNDEF FPC}<V, Iterator>{$ENDIF}.Create (AIterator : 
  Iterator; AStartIndex : Integer);
begin
  FStartIndex := AStartIndex;
  FBaseIterator := AIterator;
  FIterator := TIterator.Create(AIterator, AStartIndex);
end;

function TEnumerator{$IFNDEF FPC}<V, Iterator>{$ENDIF}.MoveNext : Boolean;
begin
  Result := FIterator.MoveNext;
end;

function TEnumerator{$IFNDEF FPC}<V, Iterator>{$ENDIF}.FirstEntry : 
  TIterator;
begin
  Result := TIterator.Create(FBaseIterator, FStartIndex);
end;

function TEnumerator{$IFNDEF FPC}<V, Iterator>{$ENDIF}.GetEnumerator : 
  TIterator;
begin
  Result := FIterator;
  FIterator := FIterator.Next;
end;

function TEnumerator{$IFNDEF FPC}<V, Iterator>{$ENDIF}.GetCurrent : TIterator;
begin
  Result := FIterator;
end;

{ TFilterEnumerator.TIterator }

constructor TFilterEnumerator{$IFNDEF FPC}<V, Iterator, Functor>{$ENDIF}
  .TIterator.Create (AIterator : Iterator; AFilter : Functor);
begin
  FInnerIterator := AIterator;
  FFunctor := AFilter;
end;

function TFilterEnumerator{$IFNDEF FPC}<V, Iterator, Functor>{$ENDIF}
  .TIterator.HasValue : Boolean;
begin
  Result := FInnerIterator.HasValue;
end;

function TFilterEnumerator{$IFNDEF FPC}<V, Iterator, Functor>{$ENDIF}
  .TIterator.Next : TIterator;
begin
  Result := TIterator.Create(Iterator(FInnerIterator.Next), FFunctor);
end;

function TFilterEnumerator{$IFNDEF FPC}<V, Iterator, Functor>{$ENDIF}
  .TIterator.MoveNext : Boolean;
var
  Iter : Iterator;
begin
  Iter := Iterator(FInnerIterator);
  while Iter.HasValue and (not Boolean(FFunctor.Call(Iter.GetValue
    {$IFDEF USE_OPTIONAL}.Unwrap{$ENDIF}))) do
  begin
    Iter := Iter.Next;
  end;

  Result := Iter.HasValue;
end;

function TFilterEnumerator{$IFNDEF FPC}<V, Iterator, Functor>{$ENDIF}
  .TIterator.GetEnumerator : TIterator;
begin
  Result := TIterator.Create(FInnerIterator, FFunctor);
end;

function TFilterEnumerator{$IFNDEF FPC}<V, Iterator, Functor>{$ENDIF}
  .TIterator.GetValue : {$IFNDEF USE_OPTIONAL}V{$ELSE}TOptionalValue{$ENDIF};
begin
  Result := FInnerIterator.GetValue;
end;

function TFilterEnumerator{$IFNDEF FPC}<V, Iterator, Functor>{$ENDIF}
  .TIterator.GetCurrent : TIterator;
var
  Iter : Iterator;
begin
  Iter := Iterator(FInnerIterator);
  while Iter.HasValue and (not Boolean(FFunctor.Call(Iter.GetValue
    {$IFDEF USE_OPTIONAL}.Unwrap{$ENDIF}))) do
  begin
    Iter := Iter.Next;
  end;

  Result := TIterator.Create(Iter, FFunctor);
  FInnerIterator := Iter.Next;
end;

{ TFilterEnumerator }

constructor TFilterEnumerator{$IFNDEF FPC}<V, Iterator, Functor>{$ENDIF}
  .Create (AIterator : Iterator; AFilter : Functor);
begin
  FBaseIterator := AIterator;
  FIterator := TIterator.Create(AIterator, AFilter);
  FFunctor := AFilter;
end;

function TFilterEnumerator{$IFNDEF FPC}<V, Iterator, Functor>{$ENDIF}
  .MoveNext : Boolean;
begin
  Result := FIterator.MoveNext;
end;

function TFilterEnumerator{$IFNDEF FPC}<V, Iterator, Functor>{$ENDIF}
  .FirstEntry : TIterator;
begin
  Result := TIterator.Create(FBaseIterator, FFunctor);
end;

function TFilterEnumerator{$IFNDEF FPC}<V, Iterator, Functor>{$ENDIF}
  .GetEnumerator : TIterator;
begin
  Result := FIterator;
  FIterator := FIterator.Next;
end;

function TFilterEnumerator{$IFNDEF FPC}<V, Iterator, Functor>{$ENDIF}
  .GetCurrent : TIterator;
begin
  Result := FIterator;
end;

end.

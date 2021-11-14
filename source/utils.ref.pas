(******************************************************************************)
(*                                PascalUtils                                 *)
(*          delphi and object pascal library of utils data structures         *)
(*                                                                            *)
(*    This class is authored by @ap1973.  https://habr.com/ru/post/587240/    *)
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

unit utils.ref;

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
  {$IFDEF FPC}generic{$ENDIF} TReference<T: class> = record
  public
    type
      {$IFDEF FPC}generic{$ENDIF} Ref<V> = reference to function : V;
      TRef = class(TInterfacedObject, {$IFDEF FPC}specialize{$ENDIF}Ref<T>)
        public
          constructor Create(const AValue : T);
          destructor Destroy; override;
        protected
          function Invoke : T;
        private
          FValue : T;
      end;
  private
    FValue : T;
  public
    class function Create(const AValue : T) : Ref<T>; static; inline;
    class operator Implicit(const AValue:
      {$IFDEF FPC}specialize{$ENDIF} TReference<T>) : Ref<T>; static; inline;
    class operator Explicit(const AValue : T) :
      {$IFDEF FPC}specialize{$ENDIF} TReference<T>; static; inline;
  end; 
  
implementation

constructor TReference{$IFNDEF FPC}<T>{$ENDIF}.TRef.Create(const AValue : T);
begin
  FValue := AValue;
end;

destructor TReference{$IFNDEF FPC}<T>{$ENDIF}.TRef.Destroy;
begin
  FreeAndNil(FValue);
  inherited Destroy;
end;

function TReference{$IFNDEF FPC}<T>{$ENDIF}.TRef.Invoke : T;
begin
  Result := FValue;
end;

class function TReference{$IFNDEF FPC}<T>{$ENDIF}.Create(const AValue : T) :
  Ref<T>;
begin
  Result := TRef.Create(AValue);
end;

class operator TReference{$IFNDEF FPC}<T>{$ENDIF}.Implicit(const AValue : 
  {$IFDEF FPC}specialize{$ENDIF} TReference<T>) : Ref<T>;
begin
  Result := TRef.Create(AValue.FValue);
end;

class operator TReference{$IFNDEF FPC}<T>{$ENDIF}.Explicit(const AValue : T) :
  {$IFDEF FPC}specialize{$ENDIF} TReference<T>;
begin
  Result.FValue := AValue;
end;

end.
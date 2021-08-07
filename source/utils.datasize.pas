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

unit utils.datasize;

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
  { TDataSize }

  TDataSize = class
  public
    type
      TByteRange = 0 .. 1023;
      TKilobyteRange = 0 .. 1023;
      TMegabyteRange = 0 .. 1023;
      TGigabyteRange = 0 .. 1023;
      TTerabyteRange = type Int64;

      { TByte }

      TByte = class
      private
        FBytes : TByteRange;
      public
        constructor Create; overload;
        constructor Create (ASize : TByteRange); overload;
        constructor Create (ASize : TByte); overload;
        destructor Destroy; override;

        property Value : TByteRange read FBytes write FBytes;
      end;

      { TKilobyte }

      TKilobyte = class
      private
        FKilobytes : TKilobyteRange;
      public
        constructor Create; overload;
        constructor Create (ASize : TKilobyteRange); overload;
        constructor Create (ASize : TKilobyte); overload;
        destructor Destroy; override;

        property Value : TKilobyteRange read FKilobytes write FKilobytes;
      end;

      { TMegabyte }

      TMegabyte = class
      private
        FMegabytes : TMegabyteRange;
      public
        constructor Create; overload;
        constructor Create (ASize : TMegabyteRange); overload;
        constructor Create (ASize : TMegabyte); overload;
        destructor Destroy; override;

        property Value : TMegabyteRange read FMegabytes write FMegabytes;
      end;

      { TGigabyte }

      TGigabyte = class
      private
        FGigabytes : TGigabyteRange;
      public
        constructor Create; overload;
        constructor Create (ASize : TGigabyteRange); overload;
        constructor Create (ASize : TGigabyte); overload;
        destructor Destroy; override;

        property Value : TGigabyteRange read FGigabytes write FGigabytes;
      end;

      { TTerabyte }

      TTerabyte = class
      private
        FTerabytes : TTerabyteRange;
      public
        constructor Create; overload;
        constructor Create (ASize : TTerabyteRange); overload;
        constructor Create (ASize : TTerabyte); overload;
        destructor Destroy; override;

        property Value : TTerabyteRange read FTerabytes write FTerabytes;
      end;

  private
    FBytes : TByte;
    FKilobytes : TKilobyte;
    FMegabytes : TMegabyte;
    FGigabytes : TGigabyte;
    FTerabytes : TTerabyte;

    function GetBytes : Int64; 
      {$IFNDEF DEBUG}inline;{$ENDIF}
    
    procedure SetBytes (ASize : Int64); 
      {$IFNDEF DEBUG}inline;{$ENDIF}
    
    function GetKilobytes : Int64; 
      {$IFNDEF DEBUG}inline;{$ENDIF}
    
    procedure SetKilobytes (ASize : Int64); 
      {$IFNDEF DEBUG}inline;{$ENDIF}
    
    function GetMegabytes : Int64; 
      {$IFNDEF DEBUG}inline;{$ENDIF}
    
    procedure SetMegabytes (ASize : Int64); 
      {$IFNDEF DEBUG}inline;{$ENDIF}
    
    function GetGigabytes : Int64; 
      {$IFNDEF DEBUG}inline;{$ENDIF}
    
    procedure SetGigabytes (ASize : Int64); 
      {$IFNDEF DEBUG}inline;{$ENDIF}

    function GetTerabytes : Int64;
      {$IFNDEF DEBUG}inline;{$ENDIF}

    procedure SetTerabytes (ASize : Int64);
      {$IFNDEF DEBUG}inline;{$ENDIF}
  public
    constructor Create;
    destructor Destroy; override;

    function ToBytes : Int64; 
      {$IFNDEF DEBUG}inline;{$ENDIF}
    
    function ToKilobytes : Int64; 
      {$IFNDEF DEBUG}inline;{$ENDIF}
    
    function ToMegabytes : Int64; 
      {$IFNDEF DEBUG}inline;{$ENDIF}
    
    function ToGigabytes : Int64; 
      {$IFNDEF DEBUG}inline;{$ENDIF}

    function ToTerabytes : Int64;
      {$IFNDEF DEBUG}inline;{$ENDIF}
    
    function {%H-}ToString (ASuffix : string = '') : string;
      {$IFNDEF DEBUG}inline;{$ENDIF}

    property Bytes : Int64 read GetBytes write SetBytes;
    property b : Int64 read GetBytes write SetBytes;
    property Kilobytes : Int64 read GetKilobytes write SetKilobytes;
    property KiB : Int64 read GetKilobytes write SetKilobytes;
    property Megabytes : Int64 read GetMegabytes write SetMegabytes;
    property MiB : Int64 read GetMegabytes write SetMegabytes;
    property Gigabytes : Int64 read GetGigabytes write SetGigabytes;
    property GiB : Int64 read GetGigabytes write SetGigabytes;
    property Terabytes : Int64 read GetTerabytes write SetTerabytes;
    property TiB : Int64 read GetTerabytes write SetTerabytes;
  end;

implementation

{ TDataSize }

function TDataSize.GetBytes: Int64;
begin
  Result := FBytes.Value;
end;

procedure TDataSize.SetBytes(ASize: Int64);
begin
  if ASize <= High(TByteRange) then
  begin
    FBytes.Value := ASize;
  end else
  begin
    FBytes.Value := ASize mod 1024;
    Kilobytes := ASize div 1024;
  end;
end;

function TDataSize.GetKilobytes: Int64;
begin
  Result := FKilobytes.Value;
end;

procedure TDataSize.SetKilobytes(ASize: Int64);
begin
  if ASize <= High(TKilobyteRange) then
  begin
    FKilobytes.Value := ASize;
  end else
  begin
    FKilobytes.Value := ASize mod 1024;
    Megabytes := ASize div 1024;
  end;
end;

function TDataSize.GetMegabytes: Int64;
begin
  Result := FMegabytes.Value;
end;

procedure TDataSize.SetMegabytes(ASize: Int64);
begin
  if ASize <= High(TMegabyteRange) then
  begin
    FMegabytes.Value := ASize;
  end else
  begin
    FMegabytes.Value := ASize mod 1024;
    Gigabytes := ASize div 1024;
  end;
end;

function TDataSize.GetGigabytes: Int64;
begin
  Result := FGigabytes.Value;
end;

procedure TDataSize.SetGigabytes(ASize: Int64);
begin
  if ASize <= High(TGigabyteRange) then
  begin
    FGigabytes.Value := ASize;
  end else
  begin
    FGigabytes.Value := ASize mod 1024;
    Terabytes := ASize div 1024;
  end;
end;

function TDataSize.GetTerabytes : Int64;
begin
  Result := FTerabytes.Value;
end;

procedure TDataSize.SetTerabytes (ASize : Int64);
begin
  FTerabytes.Value := ASize;
end;

constructor TDataSize.Create;
begin
  FBytes := TByte.Create;
  FKilobytes := TKilobyte.Create;
  FMegabytes := TMegabyte.Create;
  FGigabytes := TGigabyte.Create;
  FTerabytes := TTerabyte.Create;
end;

destructor TDataSize.Destroy;
begin
  FreeAndNil(FBytes);
  FreeAndNil(FKilobytes);
  FreeAndNil(FMegabytes);
  FreeAndNil(FGigabytes);
  FreeAndNil(FTerabytes);

  inherited Destroy;
end;

function TDataSize.ToBytes: Int64;
begin
  Result := 0;
  if FTerabytes.Value > 0 then
    Result := Result + (FTerabytes.Value * 1099511628000);
  if FGigabytes.Value > 0 then
    Result := Result + (FGigabytes.Value * 1073741824);
  if FMegabytes.Value > 0 then
    Result := Result + (FMegabytes.Value * 1048576);
  if FKilobytes.Value > 0 then
    Result := Result + (FKilobytes.Value * 1024);
  if FBytes.Value > 0 then
    Result := Result + FBytes.Value;
end;

function TDataSize.ToKilobytes: Int64;
begin
  Result := 0;
  if FTerabytes.Value > 0 then
    Result := Result + (FTerabytes.Value * 1073741824);
  if FGigabytes.Value > 0 then
    Result := Result + (FGigabytes.Value * 1048576);
  if FMegabytes.Value > 0 then
    Result := Result + (FMegabytes.Value * 1024);
  if FKilobytes.Value > 0 then
    Result := Result + FKilobytes.Value;
end;

function TDataSize.ToMegabytes: Int64;
begin
  Result := 0;
  if FTerabytes.Value > 0 then
    Result := Result + (FTerabytes.Value * 1048576);
  if FGigabytes.Value > 0 then
    Result := Result + (FGigabytes.Value * 1024);
  if FMegabytes.Value > 0 then
    Result := Result + FMegabytes.Value;
end;

function TDataSize.ToGigabytes: Int64;
begin
  Result := 0;
  if FTerabytes.Value > 0 then
    Result := Result + (FTerabytes.Value * 1024);
  if FGigabytes.Value > 0 then  
    Result := Result + FGigabytes.Value;
end;

function TDataSize.ToTerabytes : Int64;
begin
  Result := FTerabytes.Value;
end;

function TDataSize.ToString (ASuffix : string): string;
begin
  if FTerabytes.Value > 0 then
  begin
    Result := Format('%0.1d,%0.2d',
      [FTerabytes.Value, FGigabytes.Value]) + ' TiB' + ASuffix;
  end else
  if FGigabytes.Value > 0 then
  begin
    Result := Format('%0.1d,%0.2d',
      [FGigabytes.Value, FMegabytes.Value]) + ' GiB' + ASuffix;
  end else
  if FMegabytes.Value > 0 then
  begin
    Result := Format('%0.1d,%0.2d',
      [FMegabytes.Value, FKilobytes.Value]) + ' MiB' + ASuffix;
  end else
  if FKilobytes.Value > 0 then
  begin
    Result := Format('%0.1d,%0.2d',
      [FKilobytes.Value, FBytes.Value]) + ' KiB' + ASuffix;
  end else
  begin
    Result := Format('%0.1d', [FBytes.Value]) + ' B' + ASuffix;
  end;
end;

{ TDataSize.TTerabyte }

constructor TDataSize.TTerabyte.Create;
begin
  FTerabytes := 0;
end;

constructor TDataSize.TTerabyte.Create(ASize : TTerabyteRange);
begin
  FTerabytes := ASize; 
end;

constructor TDataSize.TTerabyte.Create(ASize : TTerabyte);
begin
  FTerabytes := ASize.Value;
end;

destructor TDataSize.TTerabyte.Destroy;
begin
  inherited Destroy;
end;

{ TDataSize.TGigabyte }

constructor TDataSize.TGigabyte.Create;
begin
  FGigabytes := 0;
end;

constructor TDataSize.TGigabyte.Create(ASize: TGigabyteRange);
begin
  FGigabytes := ASize;
end;

constructor TDataSize.TGigabyte.Create(ASize: TGigabyte);
begin
  FGigabytes := ASize.Value;
end;

destructor TDataSize.TGigabyte.Destroy;
begin
  inherited Destroy;
end;

{ TDataSize.TMegabyte }

constructor TDataSize.TMegabyte.Create;
begin
  FMegabytes := 0;
end;

constructor TDataSize.TMegabyte.Create(ASize: TMegabyteRange);
begin
  FMegabytes := ASize;
end;

constructor TDataSize.TMegabyte.Create(ASize: TMegabyte);
begin
  FMegabytes := ASize.Value;
end;

destructor TDataSize.TMegabyte.Destroy;
begin
  inherited Destroy;
end;

{ TDataSize.TKilobyte }

constructor TDataSize.TKilobyte.Create;
begin
  FKilobytes := 0;
end;

constructor TDataSize.TKilobyte.Create(ASize: TKilobyteRange);
begin
  FKilobytes := ASize;
end;

constructor TDataSize.TKilobyte.Create(ASize: TKilobyte);
begin
  FKilobytes := ASize.Value;
end;

destructor TDataSize.TKilobyte.Destroy;
begin
  inherited Destroy;
end;

{ TDataSize.TByte }

constructor TDataSize.TByte.Create;
begin
  FBytes := 0;
end;

constructor TDataSize.TByte.Create(ASize: TByteRange);
begin
  FBytes := ASize;
end;

constructor TDataSize.TByte.Create(ASize: TByte);
begin
  FBytes := ASize.Value;
end;

destructor TDataSize.TByte.Destroy;
begin
  inherited Destroy;
end;


end.


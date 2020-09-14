PascalUtils
==========

PascalUtils is object pascal library of utils data structures.


### Table of contents

* [Requierements](#requirements)
* [Installation](#installation)
* [Usage](#usage)
* [Data structures](#data-structures)
  * [TOptional](#toptional)
    * [Examples](#examples)
      * [Create](#create)
      * [Check state](#check-state)
      * [Get value](#get-value)
  * [TResult](#tresult)
    * [Examples](#examples-1)
      * [Create](#create-1)
      * [Check state](#check-state-1)
      * [Get value](#get-value-1)
  * [TUnaryFunctor, TBinaryFunctor](#functor)
    * [Examples](#examples-2)
      * [Specialize](#specialize)
      * [Create](#create-2)
      * [Run](#run)
  * [TDataSize](#tdatasize)
    * [Examples](#examples-3)
      * [Create](#create-3)
      * [Set value](#set-value)
      * [Get value](#get-value-2)
      * [Convert](#convert)
  * [TTimeInterval](#ttime-interval)
    * [Examples](#examples-4)
      * [Create](#create-4)
      * [Set value](#set-value-1)
      * [Get value](#get-value-1)
      * [Convert](#convert-1)
  * [TPair](#tpair)
    * [Examples](#examples-5)
      * [Create](#create-5)
      * [Get value](#get-value-2)
  * [TArrayErrorsStack, TListErrorsStack](#terrorsstack)
    * [Examples](#examples-6)
      * [Create](#create-6)
      * [Push](#push)
      * [Pop](#pop)
      * [Iterate](#iterate)




### Requirements

* [Free Pascal Compiler](http://freepascal.org)
* [Lazarus IDE](http://www.lazarus.freepascal.org/) (optional)

Library is tested with latest stable FreePascal Compiler (currently 3.2.0) and Lazarus IDE (currently 2.0.10).



### Installation

Get the sources and add the *source* directory to the *fpc.cfg* file.



### Usage

Clone the repository `git clone https://github.com/isemenkov/pascalutils`.

Add the unit you want to use to the `uses` clause.



### Data structures

#### TOptional

```pascal
uses
  utils.optional;
 
type
  generic TOptional<T> = class
```

[TOptional](https://github.com/isemenkov/pascalutils/blob/master/source/utils.optional.pas) class contains some value or none, like Rust lang.

##### Examples

###### Create

```pascal
uses
  utils.optional;

type
  TIntegerOptional = specialize TOptional<Integer>;

var
  opt_int : TIntegerOptional;

begin
  { Create none value. }
  opt_int := TIntegerOptional.Create;

  { Create integer value. }
  opt_int := TIntegerOptional.Create(4);

  FreeAndNil(opt_int);
end;
```

###### Check state

```pascal
  { Check if value is present. }
  if opt_int.IsSome then

  { Check if is value isn't. }
  if opt_int.IsNone then
```

###### Get value

```pascal
  { Get stored value. }
  writeln(opt_int.Unwrap());
```



#### TResult

```pascal
uses
  utils.result;
  
type
  generic TResult<V, E> = class
  generic TVoidResult<E> = class
```

[TResult](https://github.com/isemenkov/pascalutils/blob/master/source/utils.result.pas) class contains result value or error type like in GO or Rust lang. [TVoidResult](https://github.com/isemenkov/pascalutils/blob/master/source/utils.result.pas) class contains Ok flag or error type.

##### Examples

###### Create

```pascal
uses
  utils.result;

type
  TIntStrResult = specialize TResult<Integer, String>;

var
  res : TIntStrResult;

begin
  { Create new value. }
  res := TIntStrResult.CreateValue(-2);

  { Create new error string. }
  res := TIntStrResult.CreateError("Something wrong!");

  FreeAndNil(res);
end;
```

###### Check state

```pascal
  { Check if value is present. }
  if res.IsOk then

  { Check if error is present. }
  if res.IsErr then
```

###### Get value

```pascal
  { Get stored value. }
  writeln(res.Value);

  { Get stored error. }
  writeln(res.Error);
```



#### TUnaryFunctor, TBinaryFunctor

```pascal
uses
  utils.functor;
  
type
  generic TUnaryFunctor<V, R> = class
  generic TBinaryFunctor<V, R> = class
```

[TUnaryFunctor](https://github.com/isemenkov/pascalutils/blob/master/source/utils.functor.pas) class and [TBinaryFunctor](https://github.com/isemenkov/pascalutils/blob/master/source/utils.functor.pas) provides functor structure, like in C++ language.

##### Examples

###### Specialize

```pascal
uses
  utils.functor;

type
  TMoreIntegerFunctor = class(specialize TBinaryFunctor<Integer, Boolean>)
  public
    function Call(AValue1, AValue2 : Integer) : Boolean; override;
  end;

  function TMoreIntegerFunctor.Call (AValue1, AValue2 : Integer) : Boolean;
  begin
    if AValue1 > AValue2 then
      Result := True
    else
      Result := False;
  end;
```

###### Create

```pascal
var
  int_func : TMoreIntegerFunctor;

begin
  int_func := TMoreIntegerFunctor.Create;

  FreeAndNil(int_func);
end;
```

###### Run

```pascal
  { Run a functor. }
  if int_func(3, -5) then
```



#### TDataSize

```pascal
uses
  utils.datasize;

type
  TDataSize = class
```

[TDataSize](https://github.com/isemenkov/pascalutils/blob/master/source/utils.datasize.pas) class manipulate sizes.

##### Examples

###### Create

```pascal
uses
  utils.datasize;

var
  size : TDataSize;

begin
  size := TDataSize.Create;

  FreeAndNil(size);
end;
```

###### Set value

```pascal
  { Set bytes. }
  size.Bytes := 1024;
  size.b := 512;

  { Set kilobytes. }
  size.Kilobytes := 32;
  size.KiB := 16;

  { Set megabytes. }
  size.Megabytes := 1;
  size.MiB := 5;

  { Set gigabytes. }
  size.Gigabytes := 7;
  size.GiB := 3;

  { Set terabytes. }
  size.Terabytes := 0;
  size.TiB := 120;
```

###### Get value

```pascal
  { Get bytes. }
  writeln(size.bytes);
  writeln(size.b);

  { Get kilobytes. }
  writeln(size.Kilobytes);
  writeln(size.KiB);

  { Get Megabytes. }
  writeln(size.Megabytes);
  writeln(size.MiB);

  { Get gigabytes. }
  writeln(size.Gigabytes);
  writeln(size.GiB);

  { Get Terabytes. }
  writeln(size.Terabytes);
  writeln(size.TiB);

```

###### Convert

```pascal
  { Convert to bytes. }
  writeln(size.ToBytes);

  { Convert to kilobytes. }
  writeln(size.ToKilobytes);

  { Convert to Megabytes. }
  writeln(size.ToMegabytes);

  { Convert to Gigabytes. }
  writeln(size.ToGigabytes);

  { Convert to Terabytes. }
  writeln(size.ToTerabytes);
```



#### TTimeInterval

```pascal
uses
  utils.timeinterval;

type
  TTimeInterval = class
```

[TTimeInterval](https://github.com/isemenkov/pascalutils/blob/master/source/utils.timeinterval.pas) class manipulate time intervals.


##### Examples

###### Create

```pascal
uses
  utils.timeinterval;

var
  interval : TTimeInterval;

begin
  interval := TTimeInterval.Create;
end;
```

###### Set value

```pascal
  { Set microseconds. }
  interval.Microseconds := 432;
  interval.us := 432;

  { Set milliseconds. }
  interval.Milliseconds := 32;
  interval.ms := 21;

  { Set seconds. }
  interval.Seconds := 59;
  interval.s := 8;

  { Set minutes. }
  interval.Minutes := 32;
  interval.m := 52;

  { Set hours. }
  interval.Hours := 5;
  interval.h := 4;
```

###### Get value

```pascal
  { Get microseconds. }
  writeln(interval.Microseconds);
  writeln(interval.us);

  { Get milliseconds. }
  writeln(interval.Milliseconds);
  writeln(interval.ms);

  { Get seconds. }
  writeln(interval.Seconds);
  writeln(interval.s);

  { Get minutes. }
  writeln(interval.Minutes);
  writeln(interval.m);

  { Get hours. }
  writeln(interval.Hours);
  writeln(interval.h);
```

###### Convert

```pascal
  { Convert to microseconds. }
  writeln(interval.ToMicroseconds);

  { Convert to milliseconds. }
  writeln(interval.ToMilliseconds);

  { Convert to seconds. }
  writeln(interval.ToSeconds);

  { Convert to minutes. }
  writeln(interval.ToMinutes);

  { Convert to hours. }
  writeln(interval.ToHours);
```




#### TPair

```pascal

uses
  utils.pair;

type
  generic TPair<T1, T2> = class
```
[TPair](https://github.com/isemenkov/pascalutils/blob/master/source/utils.pair.pas) class contains pair of values like in C++ language.

##### Examples

###### Create

```pascal
uses
  utils.pair;

type
  TIntIntPair = specialize TPair<Integer, Integer>;

var
  pair : TIntIntPair;

begin
  { Create pair with default values. }
  pair := TIntIntPair.Create;

  { Create pair. }
  pair := TIntIntPair.Create(2, -4);

  FreeAndNil(pair);
end;
```

###### Get value

```pascal
  { Get first value. }
  writeln(pair.First);

  { Get second value. }
  writeln(pair.Second);
```



#### TArrayErrorsStack, TListErrorsStack

```pascal
uses
  utils.errorsstack;

type
  generic TArrayErrorsStack<T> = class
  generic TListErrorsStack<T> = class
```

[TArrayErrorsStack](https://github.com/isemenkov/pascalutils/blob/master/source/utils.errorsstack.pas) is generic stack over array of T and [TListErrorsStack](https://github.com/isemenkov/pascalutils/blob/master/source/utils.errorsstack.pas) is generic stack over list of T classes which contains errors codes.

##### Examples

###### Create

```pascal
uses
  utils.errorsstack;

type
  TStringErrorsStack = specialize TArrayErrorsStack<String>;

var
  errors : TStringErrorsStack;

begin
  errors := TStringErrorsStack.Create;

  FreeAndNil(errors);
end;

```

###### Push

```pascal
  { Push error on stack. }
  errors.Push("Something wrong!");
```

###### Pop 

```pascal
  { Pop last error. }
  writeln(errors.Pop);
```

###### Iterate

```pascal
var
  err : String;

begin
  for err in errors do
  begin
    writeln(err);
  end;
```
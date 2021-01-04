PascalUtils
==========

PascalUtils is an object library for delphi and FreePascal of data structures that implements syntactic sugar similar to that of other modern languages as far as syntax allows.


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
  * [TDataSize](#tdatasize)
    * [Examples](#examples-2)
      * [Create](#create-2)
      * [Set value](#set-value)
      * [Get value](#get-value-2)
      * [Convert](#convert)
  * [TTimeInterval](#ttime-interval)
    * [Examples](#examples-3)
      * [Create](#create-3)
      * [Set value](#set-value-1)
      * [Get value](#get-value-3)
      * [Convert](#convert-1)
  * [TPair](#tpair)
    * [Examples](#examples-4)
      * [Create](#create-4)
      * [Get value](#get-value-4)
  * [TTuple](#ttuple)
    * [Examples](#examples-5)
      * [Create](#create-5)
      * [Get value](#get-value-5)
* [Errors processing](#errors-processing)
  * [TArrayErrorsStack, TListErrorsStack](#tarrayerrorsstack-tlisterrorsstack)
    * [Examples](#examples-6)
      * [Create](#create-6)
      * [Push](#push)
      * [Pop](#pop)
      * [Iterate](#iterate)
* [Iterators](#iterators)
  * [TUnaryFunctor, TBinaryFunctor](#tunaryfunctor-tbinaryfunctor)
    * [Examples](#examples-7)
      * [Specialize](#specialize)
      * [Create](#create-7)
      * [Run](#run)
  * [TForwardIterator, TBidirectionalIterator](#tforwarditerator-tbidirectionaliterator)
    * [Examples](#examples-8)
  * [TEnumerator, TFilterEnumerator](#tenumerator-tfilterenumerator)
    * [Examples](#examples-9)
  * [TAccumulate](#taccumulate)
    * [Examples](#examples-10)
  * [TMap](#tmap)
    * [Examples](#examples-11)



### Requirements

* [Embarcadero (R) Rad Studio](https://www.embarcadero.com)
* [Free Pascal Compiler](http://freepascal.org)
* [Lazarus IDE](http://www.lazarus.freepascal.org/)



Library is tested for 

- Embarcadero (R) Delphi 10.3 on Windows 7 Service Pack 1 (Version 6.1, Build 7601, 64-bit Edition)
- FreePascal Compiler (3.2.0) and Lazarus IDE (2.0.10) on Ubuntu Linux 5.8.0-33-generic x86_64



### Installation


Get the sources and add the *source* directory to the project search path.  For FPC add the *source* directory to the *fpc.cfg* file.



### Usage

Clone the repository `git clone https://github.com/isemenkov/pascalutils`.

Add the unit you want to use to the `uses` clause.



### Data structures

#### TOptional

[TOptional](https://github.com/isemenkov/pascalutils/blob/master/source/utils.optional.pas) class represents an optional value: every TOptional is contains a value, or does not, like in Rust lang.

```pascal
uses
  utils.optional;
 
type
  generic TOptional<T> = class
```



##### Examples

###### Create

```pascal
uses
  utils.optional;

type
  TIntegerOptional = {$IFDEF FPC}type specialize{$ENDIF} TOptional<Integer>;

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

Result types typically contain either a returned value or an error, and could provide first-class encapsulation of the common (value, err) pattern ubiquitous throughout Go programs.

```pascal
uses
  utils.result;
  
type
  generic TResult<V, E> = class
  generic TVoidResult<E> = class
```



##### Examples

###### Create

```pascal
uses
  utils.result;

type
  TIntStrResult = {$IFDEF FPC}type specialize{$ENDIF} TResult<Integer, String>;

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

Functors are objects that can be treated as though they are a functions. This objects to be used with the syntax like a regular function call, and therefore its type can be used as template parameter when a generic function type is expected.

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
  TMoreIntegerFunctor = class({$IFDEF FPC}specialize{$ENDIF} TBinaryFunctor<Integer, Boolean>)
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

[TDataSize](https://github.com/isemenkov/pascalutils/blob/master/source/utils.datasize.pas) class provide the interface to manipulate data sizes.

```pascal
uses
  utils.datasize;

type
  TDataSize = class
```



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

[TTimeInterval](https://github.com/isemenkov/pascalutils/blob/master/source/utils.timeinterval.pas) class provide the interface to manipulate time intervals.

```pascal
uses
  utils.timeinterval;

type
  TTimeInterval = class
```




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

[TPair](https://github.com/isemenkov/pascalutils/blob/master/source/utils.pair.pas) class couples together a pair of values, which may be of different types (T1 and T2). The individual values can be accessed through its public members first and second, like in C++ language.

```pascal

uses
  utils.pair;

type
  generic TPair<T1, T2> = class
```


##### Examples

###### Create

```pascal
uses
  utils.pair;

type
  TIntIntPair = {$IFDEF FPC}type specialize{$ENDIF} TPair<Integer, Integer>;

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



#### TTuple

[TTuple](https://github.com/isemenkov/pascalutils/blob/master/source/utils.tuple.pas) is an object capable to hold a collection of elements. Each element can be of a different type, like in C++ language.

```pascal

uses
  utils.tuple;

type
  generic TTuple3<T1, T2, T3> = class
  generic TTuple4<T1, T2, T3, T4> = class
  generic TTuple5<T1, T2, T3, T4, T5> = class
```


##### Examples

###### Create

```pascal
uses
  utils.tuple;

type
  TIntTuple = {$IFDEF FPC}type specialize{$ENDIF} TTuple3<Integer, Integer, Integer>;

var
  tuple : TIntTuple;

begin
  { Create tuple with default values. }
  tuple := TIntTuple.Create;

  { Create tuple. }
  tuple := TIntTuple.Create(2, -4, 4);

  FreeAndNil(tuple);
end;
```

###### Get value

```pascal
  { Get first value. }
  writeln(tuple.First);

  { Get second value. }
  writeln(tuple.Second);

  { Get third value. }
  writeln(tuple.Third);
```



### Errors processing

#### TArrayErrorsStack, TListErrorsStack

[TArrayErrorsStack](https://github.com/isemenkov/pascalutils/blob/master/source/utils.errorsstack.pas) is generic stack over array of T and [TListErrorsStack](https://github.com/isemenkov/pascalutils/blob/master/source/utils.errorsstack.pas) is generic stack over list of T classes which contains errors codes.

```pascal
uses
  utils.errorsstack;

type
  generic TArrayErrorsStack<T> = class
  generic TListErrorsStack<T> = class
```



##### Examples

###### Create

```pascal
uses
  utils.errorsstack;

type
  TStringErrorsStack = {$IFDEF FPC}type specialize{$ENDIF} TArrayErrorsStack<String>;

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



### Iterators

#### TForwardIterator, TBidirectionalIterator

[TForwardIterator](https://github.com/isemenkov/pascalutils/blob/master/source/utils.enumerate.pas) and [TBidirectionalIterator](https://github.com/isemenkov/pascalutils/blob/master/source/utils.enumerate.pas) is a base classes for custom iterators.

```pascal
uses
  utils.enumerate;

type
  generic TForwardIterator<V, Iterator> = class
  generic TBidirectionalIterator<V, Iterator> = class
```



##### Examples

```pascal
uses
  utils.enumerate;

type
  TIterator = class; { Fix for FreePascal compiler. }
  TIterator = class({$IFDEF FPC}specialize{$ENDIF} TForwardIterator<Integer, TIterator>)
    { ... class methods ... }
  end;
```

```pascal
uses
  utils.enumerate;

type
  TIterator = class; { Fix for FreePascal compiler. }
  TIterator = class({$IFDEF FPC}specialize{$ENDIF}     
    TBidirectionalIterator<Integer, TIterator>)
    { ... class methods ... }
  end;
```



#### TEnumerator, TFilterEnumerator

[TEnumerator](https://github.com/isemenkov/pascalutils/blob/master/source/utils.enumerate.pas) class adds counter to an iterable objects what have iterator based on [TForwardIterator](https://github.com/isemenkov/pascalutils/blob/master/source/utils.enumerate.pas) or [TBidirectionalIterator](https://github.com/isemenkov/pascalutils/blob/master/source/utils.enumerate.pas) and returns it (the enumerate object) like in a Python language.

[TFilterEnumerator](https://github.com/isemenkov/pascalutils/blob/master/source/utils.enumerate.pas) class provides filtering enumerator by UnaryFunctor.

```pascal
uses
  utils.enumerate, utils.functor;

type
  generic TEnumerator<V, Iterator> = class
  generic TFilterEnumerator<V, Iterator, Functor> = class
```
Functor is based on [utils.functor.TUnaryFunctor](https://github.com/isemenkov/pascalutils/blob/master/source/utils.functor.pas) interface and used to filtering item value.



##### Examples

```pascal
uses
  utils.enumerate, container.arraylist, utils.functor;

type
  TIntegerArrayList = {$IFDEF FPC}specialize{$ENDIF} TArrayList<Integer, TCompareFunctorInteger>;

  TArrEnumerator = {$IFDEF FPC}specialize{$ENDIF} TEnumerator<Integer, TIntegerArrayList.TIterator>;

var
  Arr : TIntegerArrayList;
  ArrIterator : TArrEnumerator.TIterator;
  Index, Value : Integer;

begin
  for ArrIterator in TArrEnumerator.Create(Arr.FirstEntry) do
  begin
    Index := ArrIterator.Index;
    Value := ArrIterator.Value;
  end;
end;
```

```pascal
uses
  utils.enumerate, container.arraylist, utils.functor;

type
  TIntegerArrayList = {$IFDEF FPC}specialize{$ENDIF} TArrayList<Integer, TCompareFunctorInteger>;

  TFilterIntegerOddFunctor = class
    ({$IFDEF FPC}specialize{$ENDIF} TUnaryFunctor<Integer, Boolean>)
  public
    function Call(AValue : Integer) : Boolean; override;
    begin
      Result := (AValue mod 2) = 1;
    end;
  end;

  TArrOddFilterEnumerator = {$IFDEF FPC}specialize{$ENDIF} TEnumerator<Integer, 
    TIntegerArrayList.TIterator, TFilterIntegerOddFunctor>;

var
  Arr : TIntegerArrayList;
  ArrIterator : TArrOddFilterEnumerator.TIterator;
  Index, Value : Integer;

begin
  for ArrIterator in TArrOddFilterEnumerator.Create(Arr.FirstEntry) do
  begin
    Value := ArrIterator.Value;
  end;
end;
```



#### TAccumulate

[TAccumulate](https://github.com/isemenkov/pascalutils/blob/master/source/utils.functional.pas) accumulated values using binary functions (specified via the Functor argument).

```pascal
uses
  utils.functional, utils.functor;

type
  generic TAccumulate<V, Iterator, Functor> = class
```
Functor is based on [utils.functor.TUnaryFunctor](https://github.com/isemenkov/pascalutils/blob/master/source/utils.functor.pas) interface and used to accumulate the result value.



```pascal
uses
  container.arraylist, utils.functor, utils.functional;

type
  TIntegerArrayList = {$IFDEF FPC}specialize{$ENDIF} TArrayList<Integer,    
    TCompareFunctorInteger>;
  TIntegerAdditionalAccumalate = {$IFDEF FPC}specialize{$ENDIF} 
    TAccumulate<Integer, TIntegerArrayList.TIterator, TAdditionIntegerFunctor>;

begin
  writeln(TIntegerAdditionalAccumalate.Create(arr.FirstEntry, 0).Value);
end;
```



#### TMap

[TMap](https://github.com/isemenkov/pascalutils/blob/master/source/utils.functional.pas) applying the given functor to each item of a given iterable object).

```pascal
uses
  utils.functional, utils.functor;

type
  generic TMap<V, Iterator, Functor> = class
```
Functor is based on [utils.functor.TUnaryFunctor](https://github.com/isemenkov/pascalutils/blob/master/source/utils.functor.pas) interface and used to modify item value.


```pascal
uses
  container.arraylist, utils.functor, utils.functional;

type
  TIntegerArrayList = {$IFDEF FPC}specialize{$ENDIF} TArrayList<Integer,    
    TCompareFunctorInteger>;

  TIntegerPow2Functor = class
    ({$IFDEF FPC}specialize{$ENDIF} TUnaryFunctor<Integer, Integer>)
  public
    function Call (AValue : Integer) : Integer;
    begin
      Result := AValue * AValue;
    end;
  end;

  TIntegerArrayListMap = {$IFDEF FPC}specialize{$ENDIF} 
    TMap<Integer, TIntegerArrayList.TIterator, TIntegerPow2Functor>;

var
  arr : TIntegerArrayList;
  iter : TIntegerArrayListMap.TIterator;
begin
  arr := TIntegerArrayList.Create;

  for iter in TIntegerArrayListMap.Create(arr.FirstEntry, 
    TIntegerPow2Functor.Create) do
    writeln(iter.Value);
end;
```
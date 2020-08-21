PascalUtils
==========

PascalUtils is object pascal library of utils data structures.

##### TOptional

```pascal
uses
  utils.optional;
 
type
  generic TOptional<T> = class
```

[TOptional](https://github.com/isemenkov/pascalutils/blob/master/source/utils.optional.pas) class type which can contains some value or none, like Rust lang.

##### TResult

```pascal
uses
  utils.result;
  
type
  generic TResult<V, E> = class
  generic TVoidResult<E> = class
```

[TResult](https://github.com/isemenkov/pascalutils/blob/master/source/utils.result.pas) class contains result value or error type like in GO or Rust lang. [TVoidResult](https://github.com/isemenkov/pascalutils/blob/master/source/utils.result.pas) class contains Ok flag or error type.

##### TUnaryFunctor, TBinaryFunctor

```pascal
uses
  utils.functor;
  
type
  generic TUnaryFunctor<V, R> = class
  generic TBinaryFunctor<V, R> = class
```

[TUnaryFunctor](https://github.com/isemenkov/pascalutils/blob/master/source/utils.functor.pas) class and [TBinaryFunctor](https://github.com/isemenkov/pascalutils/blob/master/source/utils.functor.pas) provides functor structure, like in C++ language.

##### TDataSize

```pascal
uses
  utils.datasize;

type
  TDataSize = class
```

[TDataSize](https://github.com/isemenkov/pascalutils/blob/master/source/utils.datasize.pas) class manipulate data sizes.

##### TTimeInterval

```pascal
uses
  utils.timeinterval;

type
  TTimeInterval = class
```

[TTimeInterval](https://github.com/isemenkov/pascalutils/blob/master/source/utils.timeinterval.pas) class manipulate time intervals.

##### TPair

```pascal

uses
  utils.pair;

type
  generic TPair<T1, T2> = class
```
[TPair](https://github.com/isemenkov/pascalutils/blob/master/source/utils.pair.pas) class contains pair of values like in C++ language.

##### TArrayErrorStack, TListErrorStack

```pascal

uses
  utils.errorstack;

type
  generic TArrayErrorStack<T> = class
  generic TListErrorStack<T> = class
```

[TArrayErrorStack](https://github.com/isemenkov/pascalutils/blob/master/source/utils.errorstack.pas) is generic stack over array of T and [TListErrorStack](https://github.com/isemenkov/pascalutils/blob/master/source/utils.errorstack.pas) is generic stack over list of T classes which contains errors codes.
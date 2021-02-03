PascalUtils
==========

PascalUtils is an object library for delphi and FreePascal of data structures that implements syntactic sugar similar to that of other modern languages as far as syntax allows.


### Table of contents

* [Requierements](#requirements)
* [Installation](#installation)
* [Usage](#usage)
* [Data structures](#data-structures)
  * [TOptional](#toptional)
  * [TResult](#tresult)
  * [TVoidResult](#tvoidresult)
  * [TDataSize](#tdatasize)
  * [TTimeInterval](#ttime-interval)
  * [TPair](#tpair)
  * [TTuple](#ttuple)
  * [TVariant](#tvariant)
  * [TUnaryFunctor](#tunaryfunctor) 
  * [TBinaryFunctor](#tbinaryfunctor)
    * [TUnsortableFunctor](#tunsortablefunctor)
    * [TDefaultCompareFunctor](#tdefaultcomparefunctor)
    * [TDefaultLessFunctor](#tdefaultlessfunctor)
    * [TDefaultGreaterFunctor](#tdefaultgreaterfunctor)
    * [TDefaultEqualFunctor](#tdefaultequalfunctor)
    * [TDefaultPairKeyCompareFunctor](#tdefaultpairkeycomparefunctor)
  * [API.CString](#apicstring)
* [Errors processing](#errors-processing)
  * [TArrayErrorsStack](#tarrayerrorsstack)
  * [TListErrorsStack](#tlisterrorsstack)
* [Iterators](#iterators)
  * [TForwardIterator](#tforwarditerator) 
  * [TBidirectionalIterator](#tbidirectionaliterator)
  * [TEnumerator](#tenumerator)
  * [TFilterEnumerator](#tfilterenumerator)
  * [TAccumulate](#taccumulate)
  * [TMap](#tmap)



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

  * [Create](https://github.com/isemenkov/pascalutils/wiki/TOptional#create)
  * [IsSome](https://github.com/isemenkov/pascalutils/wiki/TOptional#issome)
  * [Unwrap](https://github.com/isemenkov/pascalutils/wiki/TOptional#unwrap)

*More details read on* [wiki page](https://github.com/isemenkov/pascalutils/wiki/TOptional).



#### TResult

Result types typically contain either a returned value or an error, and could provide first-class encapsulation of the common (value, err) pattern ubiquitous throughout Go programs.

```pascal
uses
  utils.result;
  
type
  generic TResult<V, E> = class
```

  * [Create](https://github.com/isemenkov/pascalutils/wiki/TResult#create)
  * [IsOk](https://github.com/isemenkov/pascalutils/wiki/TResult#isok)
  * [IsErr](https://github.com/isemenkov/pascalutils/wiki/TResult#iserr)
  * [Value](https://github.com/isemenkov/pascalutils/wiki/TResult#value)
  * [Error](https://github.com/isemenkov/pascalutils/wiki/TResult#error)

*More details read on* [wiki page](https://github.com/isemenkov/pascalutils/wiki/TResult).



#### TVoidResult

TVoidResult contains Ok flag or error type like in GO or Rust languages. It is a specialized TResult type with no value.

```pascal
uses
  utils.result;
  
type
  generic TVoidResult<E> = class
```

  * [Create](https://github.com/isemenkov/pascalutils/wiki/TVoidResult#create)
  * [IsOk](https://github.com/isemenkov/pascalutils/wiki/TVoidResult#isok)
  * [IsErr](https://github.com/isemenkov/pascalutils/wiki/TVoidResult#iserr)
  * [Error](https://github.com/isemenkov/pascalutils/wiki/TVoidResult#error)

*More details read on* [wiki page](https://github.com/isemenkov/pascalutils/wiki/TVoidResult).



#### TDataSize

[TDataSize](https://github.com/isemenkov/pascalutils/blob/master/source/utils.datasize.pas) class provide the interface to manipulate data sizes.

```pascal
uses
  utils.datasize;

type
  TDataSize = class
```

  * [Create](https://github.com/isemenkov/pascalutils/wiki/TDataSize#create)
  * [Values](https://github.com/isemenkov/pascalutils/wiki/TDataSize#values)
  * [Convert](https://github.com/isemenkov/pascalutils/wiki/TDataSize#convert)

*More details read on* [wiki page](https://github.com/isemenkov/pascalutils/wiki/TDataSize).



#### TTimeInterval

[TTimeInterval](https://github.com/isemenkov/pascalutils/blob/master/source/utils.timeinterval.pas) class provide the interface to manipulate time intervals.

```pascal
uses
  utils.timeinterval;

type
  TTimeInterval = class
```

  * [Create](https://github.com/isemenkov/pascalutils/wiki/TTimeInterval#create)
  * [Values](https://github.com/isemenkov/pascalutils/wiki/TTimeInterval#values)
  * [Convert](https://github.com/isemenkov/pascalutils/wiki/TTimeInterval#convert)

*More details read on* [wiki page](https://github.com/isemenkov/pascalutils/wiki/TTimeInterval).



#### TPair

[TPair](https://github.com/isemenkov/pascalutils/blob/master/source/utils.pair.pas) class couples together a pair of values, which may be of different types (T1 and T2). The individual values can be accessed through its public members first and second, like in C++ language.

```pascal

uses
  utils.pair;

type
  generic TPair<T1, T2> = class
```

  * [Create](https://github.com/isemenkov/pascalutils/wiki/TPair#create)
  * [First](https://github.com/isemenkov/pascalutils/wiki/TPair#first)
  * [Second](https://github.com/isemenkov/pascalutils/wiki/TPair#second)

*More details read on* [wiki page](https://github.com/isemenkov/pascalutils/wiki/TPair).



#### TTuple

[TTuple](https://github.com/isemenkov/pascalutils/blob/master/source/utils.tuple.pas) is an object capable to hold a collection of elements. Each element can be of a different type, like in C++ language.

```pascal

uses
  utils.tuple;

type
  generic TTuple3<T1, T2, T3> = class
  generic TTuple4<T1, T2, T3, T4> = class
  generic TTuple5<T1, T2, T3, T4, T5> = class
  generic TTuple6<T1, T2, T3, T4, T5, T6> = class
  generic TTuple7<T1, T2, T3, T4, T5, T6, T7> = class
  generic TTuple8<T1, T2, T3, T4, T5, T6, T7, T8> = class
  generic TTuple9<T1, T2, T3, T4, T5, T6, T7, T8, T9> = class
  generic TTuple10<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10> = class
```

  * [Create](https://github.com/isemenkov/pascalutils/wiki/TTuple#create)
  * [First](https://github.com/isemenkov/pascalutils/wiki/TTuple#first)
  * [Second](https://github.com/isemenkov/pascalutils/wiki/TTuple#second)
  * [Third](https://github.com/isemenkov/pascalutils/wiki/TTuple#third)
  * [Fourth](https://github.com/isemenkov/pascalutils/wiki/TTuple#fourth)
  * [Fifth](https://github.com/isemenkov/pascalutils/wiki/TTuple#fifth)
  * [Sixth](https://github.com/isemenkov/pascalutils/wiki/TTuple#sixth)
  * [Seventh](https://github.com/isemenkov/pascalutils/wiki/TTuple#sevent)
  * [Eighth](https://github.com/isemenkov/pascalutils/wiki/TTuple#eighth)
  * [Ninth](https://github.com/isemenkov/pascalutils/wiki/TTuple#ninth)
  * [Tenth](https://github.com/isemenkov/pascalutils/wiki/TTuple#tenth)

*More details read on* [wiki page](https://github.com/isemenkov/pascalutils/wiki/TTuple).



#### TVariant

[TVariant](https://github.com/isemenkov/pascalutils/blob/master/source/utils.variant.pas) is class template which represents a type-safe union. An instance of TVariant at any given time either holds a value of one of its alternative types.

```pascal

uses
  utils.variant;

type
  generic TVariant2<T1, T2> = class
  generic TVariant3<T1, T2, T3> = class
  generic TVariant4<T1, T2, T3, T4> = class
  generic TVariant5<T1, T2, T3, T4, T5> = class
  generic TVariant6<T1, T2, T3, T4, T5, T6> = class
  generic TVariant7<T1, T2, T3, T4, T5, T6, T7> = class
  generic TVariant8<T1, T2, T3, T4, T5, T6, T7, T8> = class
  generic TVariant9<T1, T2, T3, T4, T5, T6, T7, T8, T9> = class
  generic TVariant10<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10> = class
```

  * [Create](https://github.com/isemenkov/pascalutils/wiki/TVariant#create)
  * [GetType](https://github.com/isemenkov/pascalutils/wiki/TVariant#gettype)
  * [GetValue](https://github.com/isemenkov/pascalutils/wiki/TVariant#getvalue)
  * [SetValue](https://github.com/isemenkov/pascalutils/wiki/TVariant#setvalue)

*More details read on* [wiki page](https://github.com/isemenkov/pascalutils/wiki/TVariant).



#### TUnaryFunctor

Functor is instance of a class with member function `Call` defined. This member function allows the object to be used with the  same syntax as a regular function call, and therefore its type can be  used as template parameter when a generic function type is expected.

```pascal
uses
  utils.functor;
  
type
  generic TUnaryFunctor<V, R> = class
```

*More details read on* [wiki page](https://github.com/isemenkov/pascalutils/wiki/TUnaryFunctor).



#### TBinaryFunctor

Functor is instance of a class with member function `Call` defined. This member function allows the object to be used with the  same syntax as a regular function call, and therefore its type can be  used as template parameter when a generic function type is expected.

```pascal
uses
  utils.functor;
  
type
  generic TBinaryFunctor<V, R> = class
```

*More details read on* [wiki page](https://github.com/isemenkov/pascalutils/wiki/TBinaryFunctor).



##### TUnsortablefunctor

It is a special compare functor that return 0 (zero) all times. Real values not used. This functor can be used for [containers](https://github.com/isemenkov/libpasc-algorithms/wiki) for unsortable values.

```pascal
uses
  utils.functor;

type  
  TUnsortableFunctor = 
    class({$IFDEF FPC}specialize{$ENDIF} TBinaryFunctor<V, Integer>);
```

*More details read on* [wiki page](https://github.com/isemenkov/pascalutils/wiki/TBinaryFunctor#tunsortablefunctor).



##### TDefaultCompareFunctor

It is a functor which return a negative value if AValue1 should be sorted before AValue2, a positive value if AValue1 should be sorted after AValue2, zero if AValue1 and AValue2 are equal.

```pascal
uses
  utils.functor;
  
type
  generic TDefaultCompareFunctor<V> = 
    class({$IFDEF FPC}specialize{$ENDIF} TBinaryFunctor<V, Integer>)
  public
    function Call(AValue1, AValue2 : V) : Integer;
  end;
```

*More details read on* [wiki page](https://github.com/isemenkov/pascalutils/wiki/TBinaryFunctor#tdefaultcomparefunctor).



##### TDefaultLessFunctor

It is a functor which return True if AValue1 < AValue2.

```pascal
uses
  utils.functor;
  
type
  generic TDefaultLessFunctor<V> =
    class ({$IFDEF FPC}specialize{$ENDIF} TBinaryFunctor<V, Boolean>);
```

*More details read on* [wiki page](https://github.com/isemenkov/pascalutils/wiki/TBinaryFunctor#tdefaultlessfunctor).



##### TDefaultGreaterFunctor

It is a functor which return True if AValue1 > AValue2.

```pascal
uses
  utils.functor;
  
type
  generic TDefaultGreaterFunctor<V> =
    class ({$IFDEF FPC}specialize{$ENDIF} TBinaryFunctor<V, Boolean>);
```

*More details read on* [wiki page](https://github.com/isemenkov/pascalutils/wiki/TBinaryFunctor#tdefaultgreaterfunctor).



##### TDefaultEqualFunctor

It is a functor which return True if AValue1 = AValue2.

```pascal
uses
  utils.functor;
  
type
  generic TDefaultEqualFunctor<V> =
    class ({$IFDEF FPC}specialize{$ENDIF} TBinaryFunctor<V, Boolean>);
```

*More details read on* [wiki page](https://github.com/isemenkov/pascalutils/wiki/TBinaryFunctor#tdefaultequalfunctor).



##### TDefaultPairKeyCompareFunctor

It is a functor which return a negative value if pair 1 key should be sorted before pair 2 key, a positive value if pair 1 key should be sorted after pair 2 key, zero if pair 1 key and pair 2 key are equal.

```pascal
uses
  utils.functor, utils.pair;
  
uses
  generic TDefaultPairKeyCompareFunctor<K, V> =
    class({$IFDEF FPC}specialize{$ENDIF} TBinaryFunctor
    <{$IFDEF FPC}specialize{$ENDIF} TPair<K, V>, Integer>)
```

*More details read on* [wiki page](https://github.com/isemenkov/pascalutils/wiki/TBinaryFunctor#tdefaultpairkeycomparefunctor).



### API.CString

API.CString is a wrapper around C language API cstring `char *` value.

```pascal
uses
  utils.api.cstring;
  
type
  API = class
  type
    CString = class
  end;
```

  * [Create](https://github.com/isemenkov/pascalutils/wiki/API.CString#create)
  * [ToString](https://github.com/isemenkov/pascalutils/wiki/API.CString#tostring)
  * [ToPAnsiChar](https://github.com/isemenkov/pascalutils/wiki/API.CString#topansichar)
  * [ToUniquePAnsiChar](https://github.com/isemenkov/pascalutils/wiki/API.CString#touniquepansichar)
  * [Length](https://github.com/isemenkov/pascalutils/wiki/API.CString#length)

*More details read on* [wiki page](https://github.com/isemenkov/pascalutils/wiki/API.CString).



### Errors processing

#### TArrayErrorsStack

[TArrayErrorsStack](https://github.com/isemenkov/pascalutils/blob/master/source/utils.errorsstack.pas) is generic stack over array of T which contains errors codes.

```pascal
uses
  utils.errorsstack;

type
  generic TArrayErrorsStack<T> = class
```

  * [Create](https://github.com/isemenkov/pascalutils/wiki/TArrayErrorsStack#create)
  * [Push](https://github.com/isemenkov/pascalutils/wiki/TArrayErrorsStack#push)
  * [Pop](https://github.com/isemenkov/pascalutils/wiki/TArrayErrorsStack#pop)
  * [Count](https://github.com/isemenkov/pascalutils/wiki/TArrayErrorsStack#count)
  * [Iterate](https://github.com/isemenkov/pascalutils/wiki/TArrayErrorsStack#iterate)

*More details read on* [wiki page](https://github.com/isemenkov/pascalutils/wiki/TArrayErrorsStack).



#### TListErrorsStack

[TListErrorsStack](https://github.com/isemenkov/pascalutils/blob/master/source/utils.errorsstack.pas) is generic stack over list of T classes which contains errors codes.

```pascal
uses
  utils.errorsstack;

type
  generic TListErrorsStack<T> = class
```

  * [Create](https://github.com/isemenkov/pascalutils/wiki/TListErrorsStack#create)
  * [Push](https://github.com/isemenkov/pascalutils/wiki/TListErrorsStack#push)
  * [Pop](https://github.com/isemenkov/pascalutils/wiki/TListErrorsStack#pop)
  * [Count](https://github.com/isemenkov/pascalutils/wiki/TListErrorsStack#count)
  * [Iterate](https://github.com/isemenkov/pascalutils/wiki/TListErrorsStack#iterate)

*More details read on* [wiki page](https://github.com/isemenkov/pascalutils/wiki/TListErrorsStack).



### Iterators



#### TForwardIterator

[TForwardIterator](https://github.com/isemenkov/pascalutils/blob/master/source/utils.enumerate.pas) is a base class for custom forward direction iterators.

```pascal
uses
  utils.enumerate;

type
  generic TForwardIterator<V, Iterator> = class
```

  * [HasValue](https://github.com/isemenkov/pascalutils/wiki/TForwardIterator#hasvalue)
  * [Next](https://github.com/isemenkov/pascalutils/wiki/TForwardIterator#next)
  * [MoveNext](https://github.com/isemenkov/pascalutils/wiki/TForwardIterator#movenext)
  * [GetEnumerator](https://github.com/isemenkov/pascalutils/wiki/TForwardIterator#geenumerator)
  * [GetValue](https://github.com/isemenkov/pascalutils/wiki/TForwardIterator#gevalue)
  * [GetCurrent](https://github.com/isemenkov/pascalutils/wiki/TForwardIterator#getcurrent)

*More details read on* [wiki page](https://github.com/isemenkov/pascalutils/wiki/TForwardIterator).



#### TBidirectionalIterator

[TBidirectionalIterator](https://github.com/isemenkov/pascalutils/blob/master/source/utils.enumerate.pas) is a base class for custom forward and backward directions iterators.

```pascal
uses
  utils.enumerate;

type
  generic TBidirectionalIterator<V, Iterator> = class
```

  * [HasValue](https://github.com/isemenkov/pascalutils/wiki/TBidirectionalIterator#hasvalue)
  * [Next](https://github.com/isemenkov/pascalutils/wiki/TBidirectionalIterator#next)
  * [Prev](https://github.com/isemenkov/pascalutils/wiki/TBidirectionalIterator#prev)
  * [MoveNext](https://github.com/isemenkov/pascalutils/wiki/TBidirectionalIterator#movenext)
  * [GetEnumerator](https://github.com/isemenkov/pascalutils/wiki/TBidirectionalIterator#geenumerator)
  * [GetValue](https://github.com/isemenkov/pascalutils/wiki/TBidirectionalIterator#gevalue)
  * [GetCurrent](https://github.com/isemenkov/pascalutils/wiki/TBidirectionalIterator#getcurrent)

*More details read on* [wiki page](https://github.com/isemenkov/pascalutils/wiki/TBidirectionalIterator).



#### TEnumerator

[TEnumerator](https://github.com/isemenkov/pascalutils/blob/master/source/utils.enumerate.pas) class adds counter to an iterable objects what have iterator based on [TForwardIterator](https://github.com/isemenkov/pascalutils/wiki/TForwardIterator) or [TBidirectionalIterator](https://github.com/isemenkov/pascalutils/wiki/TBidirectionalIterator) and returns it (the enumerate object) like in a Python language.


```pascal
uses
  utils.enumerate;

type
  generic TEnumerator<V, Iterator> = class
```

  * [Create](https://github.com/isemenkov/pascalutils/wiki/TEnumerator#create)
  * [Iterate](https://github.com/isemenkov/pascalutils/wiki/TEnumerator#iterate)

*More details read on* [wiki page](https://github.com/isemenkov/pascalutils/wiki/TEnumerator).



#### TFilterEnumerator

[TFilterEnumerator](https://github.com/isemenkov/pascalutils/blob/master/source/utils.enumerate.pas) class provides filtering enumerator by UnaryFunctor.

```pascal
uses
  utils.enumerate, utils.functor;

type
  generic TFilterEnumerator<V, Iterator, Functor> = class
```
Functor is based on [utils.functor.TUnaryFunctor](https://github.com/isemenkov/pascalutils/wiki/TUnaryFunctor) interface and used to filtering item value.

  * [Create](https://github.com/isemenkov/pascalutils/wiki/TFilterEnumerator#create)
  * [Iterate](https://github.com/isemenkov/pascalutils/wiki/TFilterEnumerator#iterate)

*More details read on* [wiki page](https://github.com/isemenkov/pascalutils/wiki/TFilterEnumerator).



#### TAccumulate

[TAccumulate](https://github.com/isemenkov/pascalutils/blob/master/source/utils.functional.pas) accumulated values using binary functions (specified via the Functor argument).

```pascal
uses
  utils.functional, utils.functor;

type
  generic TAccumulate<V, Iterator, Functor> = class
```
Functor is based on [utils.functor.TBinaryFunctor](https://github.com/isemenkov/pascalutils/wiki/TBinaryFunctor) interface and used to accumulate the result value.

  * [Create](https://github.com/isemenkov/pascalutils/wiki/TAccumulate#create)
  * [Value](https://github.com/isemenkov/pascalutils/wiki/TAccumulate#value)
  * [Default addition functors](https://github.com/isemenkov/pascalutils/wiki/TAccumulate#default-addition-functors)
  * [Default multiplication functors](https://github.com/isemenkov/pascalutils/wiki/TAccumulate#default-multiplication-functors)

*More details read on* [wiki page](https://github.com/isemenkov/pascalutils/wiki/TAccumulate).



#### TMap

[TMap](https://github.com/isemenkov/pascalutils/blob/master/source/utils.functional.pas) applying the given functor to each item of a given iterable object).

```pascal
uses
  utils.functional, utils.functor;

type
  generic TMap<V, Iterator, Functor> = class
```
Functor is based on [utils.functor.TUnaryFunctor](https://github.com/isemenkov/pascalutils/wiki/TUnaryFunctor) interface and used to modify item value.

  * [Create](https://github.com/isemenkov/pascalutils/wiki/TMap#create)
  * [Iterate](https://github.com/isemenkov/pascalutils/wiki/TMap#iterate)

*More details read on* [wiki page](https://github.com/isemenkov/pascalutils/wiki/TMap).
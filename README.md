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
# Copyright (C) 2015 Marco Antonio Pinto
# MIT License - Look at license.txt for details.
{.deadCodeElim: on.}
import tables
import python

#
#
#
type PythonObject* = PPyObject

#
#
#
#type PythonList* = ref object of PythonObject
type PythonList* = ref object of PythonObject
type PythonTuple* = ref object of PythonObject
type PythonDict* = ref object of PythonObject

type CommonPythonObject = PythonObject or PythonList or PythonTuple or PythonList
#
#
#
#type PythonObjectable* = PythonObject or PPyObject or float or float64 or int32 or int64 or int or string or cstring or bool
#type PythonObjectable* = PythonObject or float or float64 or int32 or int64 or int or string or cstring or bool
type PythonObjectable* = PythonObject or PythonDict or PythonTuple or PythonList or float or float64 or int32 or int64 or int or string or cstring or bool
type PythonNativeObjectable* = float or float64 or int32 or int64 or int or string or cstring or bool

#
#
#
var pythonReferences*: seq[PythonObject]
var pythonEnvironmentModule*: PythonObject
#var pythonEnvironmentObject*: PythonObject
#var pythonEnvironment*: PythonDict = cast[PythonDict](PyDict_New())
var pythonEnvironmentObject*: PythonObject


#
#
#
proc addReference*[T](obj: var T): var T =
  pythonReferences.add(cast[PythonObject](obj))
  return obj

proc addReference*[T](obj: T): T =
  pythonReferences.add(cast[PythonObject](obj))
  return obj

proc addReference*(obj: PythonObject): PythonObject =
  pythonReferences.add(obj)
  return obj

#
#
#
proc initPythonObject*(): PythonObject =
  addReference(result)

#
#
#
template loadPythonModule*(name: string): system.stmt =
  discard PyRun_SimpleString("import " & name)

#
#
#
template execPython*(code: string): system.stmt =
  #if PyRun_String(code, file_input, cast[PythonObject](pythonEnvironment), cast[PythonObject](pythonEnvironment)).isNil:
  if PyRun_String(code, file_input, pythonEnvironmentObject, pythonEnvironmentObject).isNil:
    PyErr_Print()

#
# Clear the python object and the memory allocated
#
#proc release*[PythonObject](op: PythonObject) =
proc releaseComplete*[T: CommonPythonObject](op: T) =
  if op == nil: return
  if op.ob_refcnt <= 0 or op.ob_type == nil or op.ob_type.tp_dealloc == nil: return
  op.ob_refcnt = 0
  op.ob_type.tp_dealloc(cast[PPyObject](op))
  #execPython("gc.collect()")

#
# Clear the python object and the memory allocated
#
#template tryRelease*(op: var PythonObject): system.stmt =
#proc release*(op: var PythonObject) =
proc release*[T: CommonPythonObject](op: var T) =
#proc release*(op: var CommonPythonObject) =
  Py_XDECREF(cast[PPyObject](op))

#proc release*(op: PythonObject) =
proc release*[T: CommonPythonObject](op: T) =
#proc release*(op: CommonPythonObject) =
  Py_XDECREF(cast[PPyObject](op))

#
#
#
#proc pythonify*(x: var PythonObject): PythonObject {.inline.} = x
proc pythonify*[T: CommonPythonObject](x: var T): T {.inline.} = x

#proc pythonify*(x: PythonObject): PythonObject {.inline.} = x
proc pythonify*[T: CommonPythonObject](x: T): T {.inline.} = x

proc pythonify*(x: float): PythonObject {.inline.} = cast[PythonObject]( PyFloat_FromDouble(x) )

proc pythonify*(x: var float): PythonObject {.inline.} = cast[PythonObject]( PyFloat_FromDouble(x) )

#proc pythonify*(x: float64): PythonObject {.inline.} = PyFloat_FromDouble(x)

#proc pythonify*(x: var float64): PythonObject {.inline.} = PyFloat_FromDouble(x)

proc pythonify*(x: int): PythonObject {.inline.} = cast[PythonObject]( PyLong_FromLongLong(x) )

proc pythonify*(x: var int): PythonObject {.inline.} = cast[PythonObject]( PyLong_FromLongLong(x) )

proc pythonify*(x: int64): PythonObject {.inline.} = cast[PythonObject]( PyLong_FromLongLong(x) )

proc pythonify*(x: var int64): PythonObject {.inline.} = cast[PythonObject]( PyLong_FromLongLong(x) )

proc pythonify*(x: int32): PythonObject {.inline.} = cast[PythonObject]( PyLong_FromLong(x) )

proc pythonify*(x: var int32): PythonObject {.inline.} = cast[PythonObject]( PyLong_FromLong(x) )

proc pythonify*(x: string): PythonObject {.inline.} = cast[PythonObject]( PyString_FromString(cstring(x)) )

proc pythonify*(x: var string): PythonObject {.inline.} = cast[PythonObject]( PyString_FromString(cstring(x)) )

proc pythonify*(x: cstring): PythonObject {.inline.} = cast[PythonObject]( PyString_FromString(x) )

proc pythonify*(x: var cstring): PythonObject {.inline.} = cast[PythonObject]( PyString_FromString(x) )

proc pythonify*(x: bool): PythonObject {.inline.} = cast[PythonObject]( PyBool_FromLong(if cast[bool](x): 1 else: 0) )

proc pythonify*(x: var bool): PythonObject {.inline.} = cast[PythonObject]( PyBool_FromLong(if cast[bool](x): 1 else: 0) )


proc asFloat*(x: CommonPythonObject): float64 {.inline.} =
  if PyFloat_Check(cast[PPyObject](x)): return cast[PPyObject](x).PyFloat_AsDouble
  return NaN

proc asCString*(x: CommonPythonObject): cstring {.inline.} =
  if PyString_Check(cast[PPyObject](x)): return cast[PPyObject](x).PyString_AsString
  return cast[PPyObject](x).PyObject_Repr.PyString_AsString

proc asString*(x: CommonPythonObject): string {.inline.} =
  if PyString_Check(cast[PPyObject](x)): return $(cast[PPyObject](x).PyString_AsString)
  return $(cast[PPyObject](x).PyObject_Repr.PyString_AsString)

proc asLong*(x: CommonPythonObject): int64 {.inline.} =
  if PyLong_Check(cast[PPyObject](x)): return cast[PPyObject](x).PyLong_AsLongLong
  return PyLong_FromString(cast[PPyObject](x).PyObject_Repr.PyString_AsString, cast[var cstring](nil), 10).PyLong_AsLongLong

proc asInt*(x: CommonPythonObject): int32 {.inline.} =
  if PyLong_Check(cast[PPyObject](x)): return cast[PPyObject](x).PyLong_AsLong
  return PyLong_FromString(cast[PPyObject](x).PyObject_Repr.PyString_AsString, cast[var cstring](nil), 10).PyLong_AsLong

proc `$`*(x: CommonPythonObject): string {.inline.} = $x.asString

#
#2
#
proc depythonify22*[U: PythonNativeObjectable](x: PythonObject, T: typedesc[U]): U =
#template depythonify*[U: PythonNativeObjectable](x: PythonObject, T: typedesc[U]): U =
#template depythonify*[U: PythonNativeObjectable](x: PythonObject, T: typedesc[U]): U =
  when T is float:
    return cast[U](x.PyFloat_AsDouble)
  elif T is float64:
    return cast[U](x.PyFloat_AsDouble)
  elif T is int: 
    return cast[U](x.PyLong_AsLongLong)
  elif T is int64: 
    return cast[U](x.PyLong_AsLong)
  elif T is int32: 
    return cast[U](x.PyLong_AsLongLong)
  elif T is string:
    return cast[U]($(PyString_AsString(x)))
  elif T is cstring:
    return cast[U](PyString_AsString(x))
  elif T is bool: return cast[U](x.PyObject_IsTrue)
  else: nil


proc depythonif2y*[U: PythonNativeObjectable](x: PythonObject, T: typedesc[U]): U =
  if U is float: return cast[U](x.PyFloat_AsDouble)
  if U is float64: return cast[U](x.PyFloat_AsDouble)
  if U is int: return cast[U](x.PyLong_AsLongLong)
  if U is int64: return cast[U](x.PyLong_AsLong)
  if U is int32: return cast[U](x.PyLong_AsLongLong)
  if U is string: return cast[U]($(PyString_AsString(x)))
  if U is cstring: return cast[U](PyString_AsString(x))
  if U is bool: return cast[U](x.PyObject_IsTrue)

proc depythonify*[U: typedesc[float]](x: PythonObject, T: U): float = x.PyFloat_AsDouble

proc depythonify*[U: float64](x: PythonObject, T: typedesc[U]): float64 = x.PyFloat_AsDouble

proc depythonify*[U: int](x: PythonObject, T: typedesc[U]): int = cast[int](x.PyLong_AsLongLong)

proc depythonify*[U: int64](x: PythonObject, T: typedesc[U]): int64 = x.PyLong_AsLongLong

proc depythonify*[U: int32](x: PythonObject, T: typedesc[U]): int32 = x.PyLong_AsLong

proc depythonify*[U: string](x: PythonObject, T: typedesc[U]): string = $x.PyString_AsString

proc depythonify*[U: cstring](x: PythonObject, T: typedesc[U]): cstring = x.PyString_AsString

proc depythonify*[U: bool](x: PythonObject, T: typedesc[U]): bool = x.PyObject_IsTrue

template depythonify1*[U: PythonNativeObjectable](x: PythonObject, T: typedesc[U]): system.expr {.immediate.} =
  when T is float: x.PyFloat_AsDouble
  when T is float64: x.PyFloat_AsDouble
  when T is int: x.PyLong_AsLongLong
  when T is int64: x.PyLong_AsLong
  when T is int32: x.PyLong_AsLongLong
  when T is string: $(PyString_AsString(x))
  when T is cstring: x.PyString_AsString
  when T is bool: x.PyObject_IsTrue

#
#
#
type PythonObjectAttr = ref object of PythonObject

#
#
#
proc `attrs`*(obj: var PythonObject): PythonObjectAttr {.inline.} =
  new(result)
  result = cast[PythonObjectAttr](obj)

proc `attrs`*(obj: PythonObject): PythonObjectAttr {.inline.} =
  new(result)
  result = cast[PythonObjectAttr](obj)

#
#
#
proc getItem*(obj: PythonObjectAttr, attr: string): PythonObject {.inline.} = cast[PythonObject](PyObject_GetAttrString(cast[PythonObject](obj), cstring(attr)))

proc `[]`*(obj: PythonObjectAttr, attr: string): PythonObject {.inline.} = getItem(obj, attr)

proc setItem*[T](obj: PythonObjectAttr, attr: string, value: T) {.inline.} = discard PyObject_SetAttrString(cast[PythonObject](obj), cstring(attr), cast[PythonObject](value.pythonify))

proc `[]=`*[T](obj: PythonObjectAttr, attr: string, value: T) {.inline.} = setItem(obj, attr, value)



#
# Primitive functions
#
#proc PyList_Append*(ob1, ob2: PPyObject): int{.cdecl, importc, dynlib: dllname.} #-
#proc PyList_AsTuple*(ob: PPyObject): PPyObject{.cdecl, importc, dynlib: dllname.} #+
#proc PyList_GetItem*(ob: PPyObject, i: int): PPyObject{.cdecl, importc, dynlib: dllname.} #-
#proc PyList_GetSlice*(ob: PPyObject, i1, i2: int): PPyObject{.cdecl, importc, dynlib: dllname.} #-
#proc PyList_Insert*(dp: PPyObject, idx: int, item: PPyObject): int{.cdecl, importc, dynlib: dllname.} #-
#proc PyList_New*(size: int): PPyObject{.cdecl, importc, dynlib: dllname.} #-
#proc PyList_Reverse*(ob: PPyObject): int{.cdecl, importc, dynlib: dllname.} #-
#proc PyList_SetItem*(dp: PPyObject, idx: int, item: PPyObject): int{.cdecl, importc, dynlib: dllname.} #-
#proc PyList_SetSlice*(ob: PPyObject, i1, i2: int, ob2: PPyObject): int{.
#      cdecl, importc, dynlib: dllname.}                 #+
#proc PyList_Size*(ob: PPyObject): int{.cdecl, importc, dynlib: dllname.} #-
#proc PyList_Sort*(ob: PPyObject): int{.cdecl, importc, dynlib: dllname.} #-


#
#
#
proc newPythonList*(obj: PythonObject): PythonList {.inline.} = 
  result = cast[PythonList](obj.addReference())

#
#
#
proc newPythonList*(obj: var PythonObject): PythonList {.inline.} = 
  result = cast[PythonList](obj.addReference())

#
#
#
proc newPythonList*(size: int): PythonList {.inline.} = 
  result = cast[PythonList](cast[PythonObject](PyList_New(size)).addReference())

#
#
#
proc pythonify*[T](data: var openarray[T]): PythonList {.inline.} = 
  result = newPythonList(data.len)
  for index, value in mpairs(data):
    result[index] = value.pythonify

proc pythonify*[T](data: openarray[T]): PythonList {.inline.} = 
  result = newPythonList(data.len)
  for index, value in pairs(data):
    result[index] = value.pythonify

#
#
#
proc asPyList*(obj: PythonObject): PythonList {.inline.} = newPythonList(obj)

#
#
#
proc asList*(obj: PythonList, T: typedesc): seq[T] {.inline.} =
  result = newSeq[T]()
  for i in countup(0, obj.len-1):
    result.add(cast[T](obj[i].depythonify(T)))

proc asList*[U](obj: PythonObject, T: typedesc[U]): seq[U] {.inline.} =
  result = asList(obj.asPyList, T)

#
#
#
proc len*(p: PythonList): Natural {.inline.} = PyList_Size(cast[PPyObject](p))

#
#
#
proc sort*(p: PythonList) {.inline.} = discard PyList_Sort(cast[PPyObject](p))

#
#
#
proc reverse*(p: PythonList) {.inline.} = discard PyList_Reverse(cast[PPyObject](p))

#
#
#
proc getItem*(p: PythonList, index: Natural): PythonObject {.inline.} = PyList_GetItem(cast[PPyObject](p), index)

proc `[]`*(p: PythonList, index: Natural): PythonObject {.inline.} = getItem(p, index)

proc getItem*(p: var PythonList, index: Natural): PythonObject {.inline.} = PyList_GetItem(cast[PPyObject](p), index)

proc `[]`*(p: var PythonList, index: Natural): PythonObject {.inline.} = getItem(p, index)

#
#
#
proc insertItem*(p: var PythonList, index: Natural, val: PythonObjectable) {.inline.} = discard PyList_Insert(cast[PPyObject](p), index, val.pythonify)
#
#
#
proc setItem*(p: var PythonList, index: Natural, val: PythonObjectable) {.inline.} = discard PyList_SetItem(cast[PPyObject](p), index, cast[PPyObject](val.pythonify))

proc `[]=`*(p: var PythonList, index: Natural, val: PythonObjectable) {.inline.} = setItem(p, index, val)

#
#
#
proc getSlice*(p: PythonList, indexA: Natural, indexB: Natural): PythonObject {.inline.} = PyList_GetSlice(cast[PPyObject](p), indexA, indexB)

proc `[]`*(p: PythonList, indexA: Natural, indexB: Natural): PythonObject {.inline.} = getSlice(p, indexA, indexB)

proc getSlice*(p: var PythonList, indexA: Natural, indexB: Natural): PythonObject {.inline.} = PyList_GetSlice(cast[PPyObject](p), indexA, indexB)

proc `[]`*(p: var PythonList, indexA: Natural, indexB: Natural): PythonObject {.inline.} = getSlice(p, indexA, indexB)

#
#
#
proc setSlice*(p: var PythonList, indexA: Natural, indexB: Natural, val: PythonObjectable) {.inline.} = discard PyList_SetSlice(p, indexA, indexB, val.pythonify)

proc `[]=`*(p: var PythonList, indexA: Natural, indexB: Natural, val: PythonObjectable) {.inline.} = setSlice(p, indexA, indexB, val)

#
#
#
proc appendItem*(p: var PythonList, obj: PythonObjectable) {.inline.} = discard PyList_Append(p, obj.pythonify)

#
#
#
#proc asPyTuple*(p: PythonList): PythonTuple {.inline.} = newPythonTuple(PyList_AsTuple(p))
#proc asPyTuple*(p: var PythonList): PythonTuple {.inline.} = newPythonTuple(PyList_AsTuple(p))


#
# Primitive functions
#
#proc PyTuple_GetItem*(ob: PPyObject, i: int): PPyObject{.cdecl, importc, dynlib: dllname.} #-
#proc PyTuple_GetSlice*(ob: PPyObject, i1, i2: int): PPyObject{.cdecl, importc, dynlib: dllname.} #+
#proc PyTuple_New*(size: int): PPyObject{.cdecl, importc, dynlib: dllname.} #+
#proc PyTuple_SetItem*(ob: PPyObject, key: int, value: PPyObject): int{.cdecl, importc, dynlib: dllname.} #+
#proc PyTuple_Size*(ob: PPyObject): int{.cdecl, importc, dynlib: dllname.} #+

#
#
#
proc newPythonTuple*(obj: PythonObject): PythonTuple {.inline.} = 
  result = cast[PythonTuple](obj.addReference())

proc newPythonTuple*(obj: var PythonObject): PythonTuple {.inline.} = 
  result = cast[PythonTuple](obj.addReference())

#
#
#
proc newPythonTuple*(size: int): PythonTuple {.inline.} = 
  result = cast[PythonTuple](PyTuple_New(size).addReference())

#
#
#
proc asPythonTuple*[T](data: openarray[T]): PythonTuple {.inline.} = 
  result = newPythonTuple(data.len)
  for index, value in pairs(data):
    result[index] = value.pythonify

#
#
#
proc asPyTuple*(obj: PPyObject): PythonTuple {.inline.} = newPythonTuple(obj)

#
#
#
proc len*(p: PythonTuple): Natural {.inline.} = PyTuple_Size(cast[PythonObject](p))


#
#
#
proc getItem*(p: PythonTuple, index: Natural): PythonObject {.inline.} = PyTuple_GetItem(cast[PythonObject](p), index)

proc getItem*(p: var PythonTuple, index: Natural): PythonObject {.inline.} = PyTuple_GetItem(cast[PythonObject](p), index)

proc `[]`*(p: PythonTuple, index: Natural): PythonObject {.inline.} = getItem(p, index)

proc `[]`*(p: var PythonTuple, index: Natural): PythonObject {.inline.} = getItem(p, index)

#
#
#
proc setItem*(p: var PythonTuple, index: Natural, val: PythonObjectable) {.inline.} = discard PyTuple_SetItem(cast[PythonObject](p), index, val.pythonify)

proc `[]=`*(p: var PythonTuple, index: Natural, val: PythonObjectable) {.inline.} = setItem(p, index, val)

#
#
#
proc getSlice*(p: var PythonTuple, indexA: Natural, indexB: Natural): PythonObject {.inline.} = PyTuple_GetSlice(cast[PythonObject](p), indexA, indexB)

proc `[]`*(p: var PythonTuple, indexA: Natural, indexB: Natural): PythonObject {.inline.} = getSlice(p, indexA, indexB)

#
# Primitive functions
#
#proc PyDict_GetItem*(mp, key: PPyObject): PPyObject{.cdecl, importc, dynlib: dllname.}
#proc PyDict_SetItem*(mp, key, item: PPyObject): int{.cdecl, importc, dynlib: dllname.}
#proc PyDict_DelItem*(mp, key: PPyObject): int{.cdecl, importc, dynlib: dllname.}
#proc PyDict_Clear*(mp: PPyObject){.cdecl, importc, dynlib: dllname.}
#proc PyDict_Next*(mp: PPyObject, pos: PInt, key, value: PPPyObject): int{.
#      cdecl, importc, dynlib: dllname.}
#proc PyDict_Keys*(mp: PPyObject): PPyObject{.cdecl, importc, dynlib: dllname.}
#proc PyDict_Values*(mp: PPyObject): PPyObject{.cdecl, importc, dynlib: dllname.}
#proc PyDict_Items*(mp: PPyObject): PPyObject{.cdecl, importc, dynlib: dllname.}
#proc PyDict_Size*(mp: PPyObject): int{.cdecl, importc, dynlib: dllname.}
#proc PyDict_DelItemString*(dp: PPyObject, key: cstring): int{.cdecl, importc, dynlib: dllname.}
#proc PyDict_New*(): PPyObject{.cdecl, importc, dynlib: dllname.}
#proc PyDict_GetItemString*(dp: PPyObject, key: cstring): PPyObject{.cdecl, importc, dynlib: dllname.}
#proc PyDict_SetItemString*(dp: PPyObject, key: cstring, item: PPyObject): int{.
#      cdecl, importc, dynlib: dllname.}

import tables

#
#
#
proc newPythonDict*(obj: PythonObject): PythonDict {.inline.} = cast[PythonDict](obj).addReference()

proc newPythonDict*(obj: var PythonObject): PythonDict {.inline.} = cast[PythonDict](obj).addReference()

#
#
#
proc newPythonDict*(): PythonDict {.inline.} = 
  result = cast[PythonDict](PyDict_New()).addReference()

#
#
#
proc pythonify*[K, V](data: Table[K, V]): PythonDict {.inline.} = 
  result = newPythonDict(data.len)
  for index, value in pairs(data):
    result[index.pythonify] = value.pythonify

proc pythonify*[K, V](data: var Table[K, V]): PythonDict {.inline.} = 
  result = newPythonDict(data.len)
  for index, value in pairs(data):
    result[index.pythonify] = value.pythonify

#
#
#
proc asPyDict*(obj: PythonObject): PythonDict {.inline.} = newPythonDict(obj)

proc asPyDict*(obj: var PythonObject): PythonDict {.inline.} = newPythonDict(obj)

#
#
#
proc len*(p: PythonDict): Natural {.inline.} = PyDict_Size(cast[PythonObject](p))

#
#
#
proc clear*(p: PythonDict) {.inline.} = PyDict_Clear(cast[PythonObject](p))

#
#
#
proc items*(p: PythonDict): PythonTuple {.inline.} = newPythonTuple(PyDict_Items(cast[PythonObject](p)))

#
#
#
proc keys*(p: PythonDict): PythonTuple {.inline.} = newPythonTuple(PyDict_Keys(cast[PythonObject](p)))

#
#
#
proc values*(p: PythonDict): PythonTuple {.inline.} = newPythonTuple(PyDict_Values(cast[PythonObject](p)))

#
#
#
proc getItem*(p: PythonDict, index: PythonObjectable): PythonObject {.inline.} = PyDict_GetItem(cast[PythonObject](p), cast[PythonObject](index.pythonify))
proc getItem*(p: var PythonDict, index: PythonObjectable): PythonObject {.inline.} = PyDict_GetItem(cast[PythonObject](p), cast[PythonObject](index.pythonify))

proc `[]`*(p: PythonDict, index: PythonObjectable): PythonObject {.inline.} = getItem(p, index)
proc `[]`*(p: var PythonDict, index: PythonObjectable): PythonObject {.inline.} = getItem(p, index)

proc getItem*(p: PythonDict, index: string): PythonObject {.inline.} = PyDict_GetItemString(cast[PythonObject](p), cstring(index))
proc getItem*(p: var PythonDict, index: string): PythonObject {.inline.} = PyDict_GetItemString(cast[PythonObject](p), cstring(index))

proc `[]`*(p: PythonDict, index: string): PythonObject {.inline.} = getItem(p, index)
proc `[]`*(p: var PythonDict, index: string): PythonObject {.inline.} = getItem(p, index)

#
#
#
proc setItem*(p: PythonDict, index: PythonObjectable, val: PythonObjectable) {.inline.} = discard PyDict_SetItem(cast[PythonObject](p), cast[PythonObject](index.pythonify), cast[PythonObject](val.pythonify))
proc setItem*(p: var PythonDict, index: PythonObjectable, val: PythonObjectable) {.inline.} = discard PyDict_SetItem(cast[PythonObject](p), cast[PythonObject](index.pythonify), cast[PythonObject](val.pythonify))

proc `[]=`*(p: PythonDict, index: PythonObjectable, val: PythonObjectable) {.inline.} = setItem(p, index, val)
proc `[]=`*(p: var PythonDict, index: PythonObjectable, val: PythonObjectable) {.inline.} = setItem(p, index, val)

proc setItem*(p: PythonDict, index: string, val: PythonObjectable) {.inline.} = discard PyDict_SetItemString(cast[PythonObject](p), cstring(index), cast[PythonObject](val.pythonify))
proc setItem*(p: var PythonDict, index: string, val: PythonObjectable) {.inline.} = discard PyDict_SetItemString(cast[PythonObject](p), cstring(index), cast[PythonObject](val.pythonify))

proc `[]=`*(p: PythonDict, index: string, val: PythonObjectable) {.inline.} = setItem(p, index, val)
proc `[]=`*(p: var PythonDict, index: string, val: PythonObjectable) {.inline.} = setItem(p, index, val)

#
#
#
proc delItem*(p: PythonDict, index: PythonObjectable) {.inline.} = discard PyDict_DelItem(cast[PythonObject](p), cast[PythonObject](index.pythonify))
proc delItem*(p: var PythonDict, index: PythonObjectable) {.inline.} = discard PyDict_DelItem(cast[PythonObject](p), cast[PythonObject](index.pythonify))

proc delItem*(p: PythonDict, index: string) {.inline.} = discard PyDict_DelItemString(cast[PythonObject](p), cstring(index))
proc delItem*(p: var PythonDict, index: string) {.inline.} = discard PyDict_DelItemString(cast[PythonObject](p), cstring(index))



proc proc1() =
  var list1 = newPythonList(10_000_000)
  for i in countup(0, 10_000_000-1):
    list1[i] = i
  release(list1)
  list1.release()


##var pythonEnvironment*: PythonDict


#var pythonEnvironment*: PythonDict

#
#
#
template pythonEnvironment*(): PythonDict = cast[PythonDict](pythonEnvironmentObject)

#
#
#
#template initializePython*(): system.stmt = 
template initializePython*(initializeScripts=true) = #: system.stmt = 
#proc initializePython*() = 
  Py_Initialize()
  pythonReferences = newSeq[PythonObject]()
  pythonEnvironmentModule = PyImport_AddModule("__main__")
  pythonEnvironmentObject = PyModule_GetDict(pythonEnvironmentModule)
  if initializeScripts:
    allowLocalPythonScripts()

#
#
#
template finishingPython*(): system.stmt = 
  Py_Finalize()

#
#
#
template releasePythonObjects*(finishing = true): system.stmt = 
  for pythonRef in pythonReferences:
    pythonRef.release()
  if finishing:
    finishingPython()

#
# Allow to load local scripts
#
template allowLocalPythonScripts*(): system.stmt = 
  execPython("import os, sys, gc")
  execPython("sys.path.insert(0, os.getcwd())")


initializePython()
if isMainModule:
  initializePython()
  allowLocalPythonScripts()
  execPython("a=1")
  #var pythonEnvironment = cast[PythonDict](pythonEnvironmentObject)
  echo "FROM PYTHON: ", pythonEnvironment["a"]
  execPython("print 'Hello world'")
  execPython("""
def examp(o):
    print 'Hello world ' + str(o)
""")
  execPython("examp(2)")
  execPython("examp('again')")
  proc1()
  echo "---"
  proc1()
  echo "---"
  proc1()
  echo "---"
  proc1()
  echo "---"
  proc1()
  echo "---"
  proc1()
  echo "---"
  proc1()
  echo "---"
  proc1()
  echo "---"
  proc1()
  echo "---"
  proc1()
  echo "---"
  proc1()
  finishingPython()



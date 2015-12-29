# Copyright (C) 2015 Marco Antonio Pinto
# MIT License - Look at license.txt for details.

#
#
#
type PythonObjectable* = PythonObject or PPyObject or float or float64 or int32 or int64 or int or string or bool
type PythonNativeObjectable* = float or float64 or int32 or int64 or int or string or cstring or bool

#
#
#
proc pythonify*(x: PythonObjectable): PythonObject =
  if x is PythonObject: return cast[PythonObject](x)
  if x is PPyObject: return newPythonObject(cast[PPyObject](x))
  if x is float or x is float64: return newPythonObject(PyFloat_FromDouble(cast[float64](x)))
  if x is int: return newPythonObject(PyLong_FromLongLong(int64(cast[int](x))))
  if x is int64: return newPythonObject(PyLong_FromLongLong(cast[int64](x)))
  if x is int32: return newPythonObject(PyLong_FromLong(cast[int32](x)))
  if x is string: return newPythonObject(PyString_FromString(cstring(cast[string](x))))
  if x is bool: return newPythonObject(PyBool_FromLong(if cast[bool](x): 1 else: 0))
  return nil

proc asFloat*(x: PythonObject): float64 {.inline.} =
  if PyFloat_Check(x.internal_object): return x.internal_object.PyFloat_AsDouble
  return NaN

proc asCString*(x: PythonObject): cstring {.inline.} =
  if PyString_Check(x.internal_object): return x.internal_object.PyString_AsString
  return x.internal_object.PyObject_Repr.PyString_AsString

proc asString*(x: PythonObject): string {.inline.} =
  if PyString_Check(x.internal_object): return $(x.internal_object.PyString_AsString)
  return $(x.internal_object.PyObject_Repr.PyString_AsString)

proc asLong*(x: PythonObject): int64 {.inline.} =
  if PyLong_Check(x.internal_object): return x.internal_object.PyLong_AsLongLong
  return PyLong_FromString(x.internal_object.PyObject_Repr.PyString_AsString, cast[var cstring](nil), 10).PyLong_AsLongLong

proc asInt*(x: PythonObject): int32 {.inline.} =
  if PyLong_Check(x.internal_object): return x.internal_object.PyLong_AsLong
  return PyLong_FromString(x.internal_object.PyObject_Repr.PyString_AsString, cast[var cstring](nil), 10).PyLong_AsLong

proc `$`*(x: PythonObject): string {.inline.} = $x.asString

#
#
#
proc depythonify*[U](x: PythonObject, T: typedesc[U]): U =
  if T is float: return cast[T](x.internal_object.PyFloat_AsDouble)
  if T is float64: return cast[T](x.internal_object.PyFloat_AsDouble)
  if T is int: return cast[T](x.internal_object.PyLong_AsLongLong)
  if T is int64: return cast[T](x.internal_object.PyLong_AsLong)
  if T is int32: return cast[T](x.internal_object.PyLong_AsLongLong)
  if T is string: return cast[T]($(x.internal_object.PyString_AsString))
  if T is cstring: return cast[T](x.internal_object.PyString_AsString)
  if T is bool: return cast[T](x.internal_object.PyObject_IsTrue)
  return cast[T](nil)


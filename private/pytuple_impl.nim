# Copyright (C) 2015 Marco Antonio Pinto
# MIT License - Look at license.txt for details.

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
proc newPythonTuple*(obj: PPyObject): PythonTuple {.inline.} = 
  new(result)
  result.initPythonObject(obj)

#
#
#
proc newPythonTuple*(size: int): PythonTuple {.inline.} = 
  new(result)
  result.initPythonObject(PyTuple_New(size))

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

proc asPyTuple*(obj: PythonObject): PythonTuple {.inline.} = newPythonTuple(obj.internal_object)

#
#
#
proc len*(p: PythonTuple): Natural {.inline.} = PyTuple_Size(p.internal_object)


#
#
#
proc getItem*(p: PythonTuple, index: Natural): PythonObject {.inline.} = newPythonObject(PyTuple_GetItem(p.internal_object, index))

proc `[]`*(p: PythonTuple, index: Natural): PythonObject {.inline.} = getItem(p, index)

#
#
#
proc setItem*(p: PythonTuple, index: Natural, val: PythonObjectable) {.inline.} = discard PyTuple_SetItem(p.internal_object, index, val.pythonify.internal_object)

proc `[]=`*(p: PythonTuple, index: Natural, val: PythonObjectable) {.inline.} = setItem(p, index, val)

#
#
#
proc getSlice*(p: PythonTuple, indexA: Natural, indexB: Natural): PythonObject {.inline.} = newPythonObject(PyTuple_GetSlice(p.internal_object, indexA, indexB))

proc `[]`*(p: PythonTuple, indexA: Natural, indexB: Natural): PythonObject {.inline.} = getSlice(p, indexA, indexB)

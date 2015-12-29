# Copyright (C) 2015 Marco Antonio Pinto
# MIT License - Look at license.txt for details.

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
proc newPythonDict*(obj: PPyObject): PythonDict {.inline.} = 
  new(result)
  result.initPythonObject(obj)

#
#
#
proc newPythonDict*(): PythonDict {.inline.} = 
  new(result)
  result.initPythonObject(PyDict_New())

#
#
#
proc pythonify*[K, V](data: Table[K, V]): PythonDict {.inline.} = 
  result = newPythonDict(data.len)
  for index, value in pairs(data):
    result[index.pythonify] = value.pythonify

#
#
#
proc asDict*(obj: PPyObject): PythonDict {.inline.} = newPythonDict(obj)

proc asDict*(obj: PythonObject): PythonDict {.inline.} = newPythonDict(obj.internal_object)

#
#
#
proc len*(p: PythonDict): Natural {.inline.} = PyDict_Size(p.internal_object)

#
#
#
proc clear*(p: PythonDict) {.inline.} = PyDict_Clear(p.internal_object)

#
#
#
proc items*(p: PythonDict): PythonTuple {.inline.} = newPythonTuple(PyDict_Items(p.internal_object))

#
#
#
proc keys*(p: PythonDict): PythonTuple {.inline.} = newPythonTuple(PyDict_Keys(p.internal_object))

#
#
#
proc values*(p: PythonDict): PythonTuple {.inline.} = newPythonTuple(PyDict_Values(p.internal_object))

#
#
#
proc getItem*(p: PythonDict, index: PythonObjectable): PythonObject {.inline.} = newPythonObject(PyDict_GetItem(p.internal_object, index.pythonify.internal_object))

proc `[]`*(p: PythonDict, index: PythonObjectable): PythonObject {.inline.} = getItem(p, index)

proc getItem*(p: PythonDict, index: string): PythonObject {.inline.} = newPythonObject(PyDict_GetItemString(p.internal_object, cstring(index)))

proc `[]`*(p: PythonDict, index: string): PythonObject {.inline.} = getItem(p, index)

#
#
#
proc setItem*(p: PythonDict, index: PythonObjectable, val: PythonObjectable) {.inline.} = discard PyDict_SetItem(p.internal_object, index.pythonify.internal_object, val.pythonify.internal_object)

proc `[]=`*(p: PythonDict, index: PythonObjectable, val: PythonObjectable) {.inline.} = setItem(p, index, val)

proc setItem*(p: PythonDict, index: string, val: PythonObjectable) {.inline.} = discard PyDict_SetItemString(p.internal_object, cstring(index), val.pythonify.internal_object)

proc `[]=`*(p: PythonDict, index: string, val: PythonObjectable) {.inline.} = setItem(p, index, val)

#
#
#
proc delItem*(p: PythonDict, index: PythonObjectable) {.inline.} = discard PyDict_DelItem(p.internal_object, index.pythonify.internal_object)

proc delItem*(p: PythonDict, index: string) {.inline.} = discard PyDict_DelItemString(p.internal_object, cstring(index))

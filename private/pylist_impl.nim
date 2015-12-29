# Copyright (C) 2015 Marco Antonio Pinto
# MIT License - Look at license.txt for details.

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
proc newPythonList*(obj: PPyObject): PythonList {.inline.} = 
  new(result)
  result.initPythonObject(obj)

#
#
#
proc newPythonList*(size: int): PythonList {.inline.} = 
  new(result)
  result.initPythonObject(PyList_New(size))

#
#
#
proc pythonify*[T](data: openarray[T]): PythonList {.inline.} = 
  result = newPythonList(data.len)
  for index, value in pairs(data):
    result[index] = value.pythonify

#
#
#
proc asPyList*(obj: PPyObject): PythonList {.inline.} = newPythonList(obj)

proc asPyList(obj: PythonObject): PythonList {.inline.} = newPythonList(obj.internal_object)

#
#
#
proc asList(obj: PythonList, T: typedesc): seq[T] {.inline.} =
  result = newSeq[T]()
  for i in countup(0, obj.len-1):
    result.add(cast[T](obj[i].depythonify(T)))

proc asList(obj: PythonObject, T: typedesc): seq[T] {.inline.} = obj.asPyList.asList(T)

proc asList[T](obj: PythonList): seq[T] {.inline.} =
  result = @[]
  for i in countup(0, obj.len-1):
    result.add(obj[i])

proc asList[T](obj: PythonObject): seq[T] {.inline.} = asList[T](obj.asPyList)
#proc asList[T](obj: PythonObject): seq[T] {.inline.} = asList(cast[T](nil), obj.asPyList)

#
#
#
proc len*(p: PythonList): Natural {.inline.} = PyList_Size(p.internal_object)

#
#
#
proc sort*(p: PythonList) {.inline.} = discard PyList_Sort(p.internal_object)

#
#
#
proc reverse*(p: PythonList) {.inline.} = discard PyList_Reverse(p.internal_object)

#
#
#
proc getItem*(p: PythonList, index: Natural): PythonObject {.inline.} = newPythonObject(PyList_GetItem(p.internal_object, index))

proc `[]`*(p: PythonList, index: Natural): PythonObject {.inline.} = getItem(p, index)

#
#
#
proc insertItem*(p: PythonList, index: Natural, val: PythonObjectable) {.inline.} = discard PyList_Insert(p.internal_object, index, val.pythonify)
#
#
#
proc setItem*(p: PythonList, index: Natural, val: PythonObjectable) {.inline.} = discard PyList_SetItem(p.internal_object, index, val.pythonify.internal_object)

proc `[]=`*(p: PythonList, index: Natural, val: PythonObjectable) {.inline.} = setItem(p, index, val)

#
#
#
proc getSlice*(p: PythonList, indexA: Natural, indexB: Natural): PythonObject {.inline.} = newPythonObject(PyList_GetSlice(p.internal_object, indexA, indexB))

proc `[]`*(p: PythonList, indexA: Natural, indexB: Natural): PythonObject {.inline.} = getSlice(p, indexA, indexB)

#
#
#
proc setSlice*(p: PythonList, indexA: Natural, indexB: Natural, val: PythonObjectable) {.inline.} = discard PyList_SetSlice(p.internal_object, indexA, indexB, val.pythonify.internal_object)

proc `[]=`*(p: PythonList, indexA: Natural, indexB: Natural, val: PythonObjectable) {.inline.} = setSlice(p, indexA, indexB, val)

#
#
#
proc appendItem*(p: PythonList, obj: PythonObjectable) {.inline.} = discard PyList_Append(p.internal_object, obj.pythonify.internal_object)

#
#
#
proc asPyTuple*(p: PythonList): PythonTuple {.inline.} = newPythonTuple(PyList_AsTuple(p.internal_object))

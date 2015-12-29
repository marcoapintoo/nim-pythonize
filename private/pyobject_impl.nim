# Copyright (C) 2015 Marco Antonio Pinto
# MIT License - Look at license.txt for details.

#
#
#
type PythonObject* = ref object of RootObj
  internal_object: PPyObject
  internal_name: string

#
#
#
type PythonList* = ref object of PythonObject
type PythonTuple* = ref object of PythonObject
type PythonDict* = ref object of PythonObject

#
#
#
var python_counter_objects = 1
var python_references = initTable[string, PythonObject]()
Py_Initialize()
var pythonEnvironmentModule* = PyImport_AddModule("__main__")
var pythonEnvironmentObject* = PyModule_GetDict(pythonEnvironmentModule)

#
# Allow to load local scripts
#
discard PyRun_SimpleString("import os, sys")
discard PyRun_SimpleString("sys.path.insert(0, os.getcwd())")

#
#
#
proc loadPythonModule*(name: string) {.inline.} = discard PyRun_SimpleString("import " & name)

#
#
#
proc execPython*(code: string) {.inline.} =
  discard PyRun_String(code, file_input, pythonEnvironmentObject, pythonEnvironmentObject)

#
#
#
proc Py_CLEAR(op: PPyObject) = # Function missing in the Nim Python API
  if op == nil: return 
  op.ob_refcnt = 0
  if op.ob_type == nil or op.ob_type.tp_dealloc == nil: return 
  op.ob_type.tp_dealloc(op)

#
#
#
proc releasePythonObject*(name: string, remove_from_list = true) = 
  echo "!Decreasing references to: ", name
  python_references.mget(name).internal_object.Py_CLEAR()
  if remove_from_list: python_references.del(name)

#
#
#
proc release*(obj: PythonObject, remove_from_list = true) =
  #echo "!!Decreasing references to: ", obj.internal_name
  obj.internal_object.Py_CLEAR()#obj.internal_object.Py_XDECREF()
  if remove_from_list: python_references.del(obj.internal_name)

#
#
#
proc releasePythonObjects*() = 
  for obj in python_references.values:
    #echo "!!!Decreasing references to: ", obj.internal_name
    obj.internal_object.Py_CLEAR()
  python_references = initTable[string, PythonObject]()
  Py_Finalize()

#
#
#
proc initPythonObject*(result: var PythonObject, obj: PPyObject) =
  result.internal_object = obj
  result.internal_name = "PythonObject" & $python_counter_objects
  inc(python_counter_objects)
  python_references[result.internal_name] = result

#
#
#
proc newPythonObject*(): PythonObject =
  new(result)
  result.initPythonObject(nil)

proc newPythonObject*(obj: PPyObject): PythonObject =
  new(result)
  result.initPythonObject(obj)






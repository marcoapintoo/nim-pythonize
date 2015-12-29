# Copyright (C) 2015 Marco Antonio Pinto
# MIT License - Look at license.txt for details.

#
#
#
type PythonObjectAttr = ref object of PythonObject

#
#
#
proc `attrs`*(obj: PythonObject): PythonObjectAttr {.inline.} =
  new(result)
  result.internal_object = obj.internal_object
  result.internal_name = "ATTRIBUTE-OBJECT"#obj.internal_name

#
#
#
proc `[]`*(obj: PythonObjectAttr, attr: string): PythonObject {.inline.} = newPythonObject(PyObject_GetAttrString(obj.internal_object, attr))

proc `[]=`*(obj: PythonObjectAttr, attr: string, value: PythonObject) {.inline.} = discard PyObject_SetAttrString(obj.internal_object, attr, value.internal_object)

proc `[]=`*[T](obj: PythonObjectAttr, attr: string, value: T) {.inline.} = discard PyObject_SetAttrString(obj.internal_object, attr, value.pythonify.internal_object)



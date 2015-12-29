# Copyright (C) 2015 Marco Antonio Pinto
# MIT License - Look at license.txt for details.
{.deadCodeElim: on.}
import python
import tables

include private/pyobject_impl
include private/pyobjectable_impl
include private/pytuple_impl
include private/pylist_impl
include private/pydict_impl
include private/pyobjectattr_impl

#var pythonEnvironment* = PyModule_GetDict(pythonEnvironmentModule).asDict
var pythonEnvironment* = pythonEnvironmentObject.asDict


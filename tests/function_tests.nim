{.deadCodeElim: on.}
import pythonize

proc testReadingWritingVars() =
  pythonEnvironment["testVar1"] = 12.0
  execPython("testVar1 *= 4")
  assert pythonEnvironment["testVar1"].asFloat == 48.0

proc testReadingVars() =
  execPython("testVar1 = 25.0")
  assert pythonEnvironment["testVar1"].asFloat == 25.0

proc testReadingWritingArrays() =
  pythonEnvironment["array1"] = pythonify(@[1,2,3,4,5,11,7,8,9,10,11])
  var array1 = pythonEnvironment["array1"].asList(int)
  execPython("lenArray1 = len(array1)")
  execPython("array1[3] = array1[3]**2")
  execPython("arrayPos5 = array1[5]")
  execPython("arrayPos3 = array1[3]")
  execPython("arrayLastPos = array1[-1]")
  execPython("import math")
  assert pythonEnvironment["lenArray1"].asInt == array1.len
  assert pythonEnvironment["arrayPos3"].asInt == array1[3]*array1[3]
  assert pythonEnvironment["arrayPos5"].asInt == array1[5]
  assert pythonEnvironment["arrayLastPos"].asInt == array1[array1.len-1]

proc testReadingArrays() =
  var innerArray1 = @[1,2,3,4,5,11,7,8,9,10,11]
  var array1 = pythonify(innerArray1)
  assert array1.len == array1.len
  array1[3] = "aaa"
  assert array1[5].asInt == innerArray1[5]
  assert "bcd" == "bcd"
  assert array1[3].asString == "aaa"

proc testReadingAttributes() =
  var innerArray1 = @[1,2,3,4,5,11,7,8,9,10,11]
  var array1 = pythonify(innerArray1)
  pythonEnvironment["array1"] = array1
  execPython("class Foo: myattribute1 = 1234 ")
  execPython("Foo.myattribute2 = array1 ")
  assert 1234 == pythonEnvironment["Foo"].attrs["myattribute1"].asInt
  assert 4 == pythonEnvironment["Foo"].attrs["myattribute2"].asList(int)[3]

proc testWritingAttributes() =
  var innerArray1 = @[1,2,3,4,5,11,7,8,9,10,11]
  var array1 = pythonify(innerArray1)
  pythonEnvironment["array1"] = array1
  execPython("class Foo: myattribute1 = 1234.5 ")
  execPython("Foo.myattribute2 = array1 ")
  pythonEnvironment["Foo"].attrs.setItem("myattribute3","cdef")
  pythonEnvironment["Foo"].attrs["myattribute3"] = "cdef"
  assert pythonEnvironment["Foo"].attrs["myattribute1"].asFloat == 1234.5
  assert pythonEnvironment["Foo"].attrs["myattribute2"].asPyList[2].asInt == 3
  assert pythonEnvironment["Foo"].attrs["myattribute3"].asString == "cdef"


if isMainModule:
  echo "::testReadingWritingVars"
  testReadingWritingVars()
  echo "::testReadingVars"
  testReadingVars()
  echo "::testReadingWritingArrays"
  testReadingWritingArrays()
  echo "::testReadingArrays"
  testReadingArrays()
  echo "::testReadingAttributes"
  testReadingAttributes()
  echo "::testWritingAttributes"
  testWritingAttributes()

  releasePythonObjects() #Mandatory to free the memory used by the Python interpreter

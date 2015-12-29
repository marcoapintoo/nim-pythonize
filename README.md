# Pythonize [![nimble](https://raw.githubusercontent.com/yglukhov/nimble-tag/master/nimble.png)](https://github.com/yglukhov/nimble-tag)

Pythonize is a high-level wrapper to interface the Nim and Python programming languages. It is focused on making the interaction more easy using the pythonify/depythonify functions.

Do you want to plot something?

```nim
import pythonize

pythonEnvironment["signal"] = @[0, 2290, 4001, 5122, 5686, 5756, 5419, 
                                4773, 3919, 2955, 1966, 1026, 188, 0].pythonify
execPython("import pylab")
execPython("pylab.fill(signal)")
execPython("pylab.show()")

releasePythonObjects()
```

![Plot screenshot](https://raw.githubusercontent.com/marcoapintoo/nim-pythonize/master/tests/plot_screenshot.png)

# Another Python API?

Already there is a wrapper for the Python C-API in the Nimble repository (https://github.com/nim-lang/python), so why another wrapper?

Nim is a great and fast language, but there is a lack of several libraries to do other tasks. And in the opposite, Python is full with libraries for almost anything (with different quality levels, of course). Thus, the most logical attitude is to make a bridge between both languages using the low-level API for Python.

For example, to find the md5 code for a sample text using the md5 Python library:

```nim
import python

# Initialize Python
Py_Initialize()
# Define parameters
var text_to_encode = "Hello world!"
# Interface with Python
var py_text_to_encode = PyString_FromString(text_to_encode)
var py_environment_module = PyImport_ImportModule("__main__")
var py_environment_vars = PyModule_GetDict(py_environment_module)
discard PyDict_SetItemString(py_environment_vars, "text", py_text_to_encode)
discard PyRun_SimpleString("import md5")
discard PyRun_SimpleString("encoded_text = md5.md5(text).hexdigest()")
var py_encoded_text = PyDict_GetItemString(py_environment_vars, "encoded_text")
# Recover results and show them
var encoded_text = PyString_AsString(py_encoded_text)
echo "Text: ", text_to_encode
echo "Encoded Text: ", encoded_text
# Freeing memory
Py_XDECREF(py_environment_module)
Py_XDECREF(py_text_to_encode)
Py_XDECREF(py_encoded_text)
Py_Finalize()
```

The code will work successfully, but it seems a... little ugly.

Pythonize uses several abstractions to reduce the repetitive code 

```nim
import pythonize # Implicit Python initialization
# Define parameters
var text_to_encode = "Hello world!"
# Interface with Python
pythonEnvironment["text"] = text_to_encode
execPython("import md5")
execPython("encoded_text = md5.md5(text).hexdigest()")
# Recover results and show them
var encoded_text = pythonEnvironment["encoded_text"].depythonify(string)
# Alternatively: var encoded_text = pythonEnvironment["encoded_text"].asString
echo "Text: ", text_to_encode
echo "Encoded Text: ", encoded_text
# Freeing memory
releasePythonObjects() # To free the memory used by Python
```

# More examples

## Reading simple variables

```nim
proc testReadingVars() =
execPython("testVar1 = 25.0")
assert pythonEnvironment["testVar1"].asFloat == 25.0
```

## Reading & writing simple values

```nim
pythonEnvironment["testVar1"] = 12.0
execPython("testVar1 *= 4")
assert pythonEnvironment["testVar1"].asFloat == 48.0
```

## Reading sequences

```nim
var innerArray1 = @[1,2,3,4,5,11,7,8,9,10,11]
var array1 = pythonify(innerArray1)
assert array1.len == array1.len
array1[3] = "aaa"
assert array1[5].asInt == innerArray1[5]
assert "bcd" == "bcd"
assert array1[3].asString == "aaa"
```

## Reading & writing sequences

```nim
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
```

## Reading attributes

```nim
var innerArray1 = @[1,2,3,4,5,11,7,8,9,10,11]
var array1 = pythonify(innerArray1)
pythonEnvironment["array1"] = array1
execPython("class Foo: myattribute1 = 1234 ")
execPython("Foo.myattribute2 = array1 ")
assert 1234 == pythonEnvironment["Foo"].attrs["myattribute1"].asInt
assert 4 == pythonEnvironment["Foo"].attrs["myattribute2"].asList(int)[3]
```

## Reading & writing object attributes

```nim
var innerArray1 = @[1,2,3,4,5,11,7,8,9,10,11]
var array1 = pythonify(innerArray1)
pythonEnvironment["array1"] = array1
execPython("class Foo: myattribute1 = 1234.5 ")
execPython("Foo.myattribute2 = array1 ")
pythonEnvironment["Foo"].attrs["myattribute3"] = "cdef"
assert pythonEnvironment["Foo"].attrs["myattribute1"].asFloat == 1234.5
assert pythonEnvironment["Foo"].attrs["myattribute2"].asPyList[2].asInt == 3
assert pythonEnvironment["Foo"].attrs["myattribute3"].asString == "cdef"
```

# License

The source code is delivered under a MIT License.


# Current status

The project is under development according to my current needs and it is possible it will change during the process.







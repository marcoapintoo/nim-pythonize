#
# Using a md5 coding technique using Python
#
import python

Py_Initialize()
var text_to_encode = "Hello world!"
var py_text_to_encode = PyString_FromString(text_to_encode)
var py_environment_module = PyImport_ImportModule("__main__")
var py_environment_vars = PyModule_GetDict(py_environment_module)
discard PyDict_SetItemString(py_environment_vars, "text", py_text_to_encode)
discard PyRun_SimpleString("import md5")
discard PyRun_SimpleString("encoded_text = md5.md5(text).hexdigest()")
var py_encoded_text = PyDict_GetItemString(py_environment_vars, "encoded_text")
var encoded_text = PyString_AsString(py_encoded_text)
echo "Text: ", text_to_encode
echo "Encoded Text: ", encoded_text
Py_XDECREF(py_environment_module)
Py_XDECREF(py_text_to_encode)
Py_XDECREF(py_encoded_text)
Py_Finalize()


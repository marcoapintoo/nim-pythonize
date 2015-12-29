#
# Using a md5 coding technique using Python
#
import pythonize

var text_to_encode = "Hello world!"
pythonEnvironment["text"] = text_to_encode
execPython("import md5")
execPython("encoded_text = md5.md5(text).hexdigest()")
var encoded_text = pythonEnvironment["encoded_text"].depythonify(string)
echo "Text: ", text_to_encode
echo "Encoded Text: ", encoded_text
releasePythonObjects() # To free the memory used by Python
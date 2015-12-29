import pythonize

pythonEnvironment["signal"] = @[0, 2290, 4001, 5122, 5686, 5756, 5419, 4773, 3919, 2955, 1966, 1026, 188, 0].pythonify
execPython("import pylab")
execPython("pylab.fill(signal)")
execPython("pylab.show()")

releasePythonObjects()
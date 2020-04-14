from distutils.core import setup
from Cython.Build import cythonize

setup(ext_modules=cythonize(['run.py', 'systems.py', 'rates.py', 'plots.py'], compiler_directives={'language_level' : '3'}))

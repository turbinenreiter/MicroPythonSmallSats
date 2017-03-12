### MicroPython

A MicroPython interpreter exists for Linux on ARM as well as for microcontrollers using ARM Cortex M series or Tensilica cores. A full implementation and documentation of the Hardware API only exists for the STM32F4 family of microcontrollers from STMicroelectronics and the ESP8266 microcontroller. Currently, API implementations for Atmel SAMD21 as well as Kinetics MK20DX are being developed. Porting is generally possible to all platforms for which a C compiler is available and that have sufficient storage and memory, the main challenge being the implementation of the Hardware API.

MicroPython's project structure and build-system allow for easy modification of the interpreter, as well as addition of custom modules, and can be compiled with a fully Open Source toolchain. However, the internal C API is not extensively documented. Some examples and information are provided by the community, but the missing documentation is clearly a weakpoint, as the possibility to customize and extend, and the simplicity with which this can be done, is a key factor.

Because of the different internal structure of MicroPython compared to CPython, Python modules developed for CPython in other languages than Python do not work with MicroPython. Pure Python modules work with MicroPython as long as their own dependencies are met.

### Linting tools

As MicroPython adheres to the Python syntax, all Python tools can be used. This includes syntax highlighting in editors as well as code linting tools like Pylint. Pylint allows to enforce coding standards,for example naming conventions, line length, dead-code detection, and thereby aids readability and maintainability of the code. It also provides error checking which helps addressing the problem of runtime errors in interpreted languages.

### Static type checking

Python is a dynamically typed language, which also creates the risk of runtime errors. Mypy is a tool providing static type checking using type hints that are allowed in the Python syntax. In MicroPython, these type hints can even be used to compile functions to native assembler code, providing better performance.

### Practical use

For practical working with MicroPython on a microcontroller only the most basic tools are needed: a text editor and a serial terminal. Source code can be directly copied onto the microcontroller storage, which, when connected to a computer with a USB cable, acts as a Mass Storage Device (MSD). The code copied onto the storage is then compiled to bytecode on the microcontroller itself and is executed. Using a serial terminal application, a read–eval–print loop (REPL) can be accessed, allowing to interactively type in code that gets executed by the microcontroller. The usual debugging cycle of microcontroller programming (write $\\rightarrow$ compile $\\rightarrow$ flash$\\rightarrow$ run) is drastically shortened to just write and run.

~~~{.bash}
$ picocom /dev/ttyACM0

MicroPython v1.8.7-298-g465a604-dirty on 2017-02-20; PYBv1.0 with STM32F405RG
Type "help()" for more information.
>>> help()
Welcome to MicroPython!
For online help please visit http://micropython.org/help/.
...
For further help on a specific object, type help(obj)
For a list of available modules, type help('modules')
>>> 
~~~

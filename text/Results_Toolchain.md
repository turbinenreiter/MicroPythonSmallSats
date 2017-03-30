### MicroPython

MicroPython is the language implementation of Python used in this study. A MicroPython interpreter exists for Linux on ARM as well as for microcontrollers using ARM Cortex M series or Tensilica cores. A full implementation and documentation of the Hardware API only exists for the STM32F4 family of microcontrollers from STMicroelectronics and the ESP8266 microcontroller. Currently, API implementations for Atmel SAMD21 as well as Kinetics MK20DX are being developed. Porting is generally possible to all platforms for which a C compiler is available and that have sufficient storage and memory, the main challenge being the implementation of the Hardware API.

MicroPython's project structure and build-system allow for easy modification of the interpreter, as well as addition of custom modules, and can be compiled with a fully Open Source toolchain. However, the internal C API is not extensively documented. Some examples and information are provided by the community, but the missing documentation is clearly a weakpoint, as the possibility to customize and extend, and the simplicity with which this can be done, is a key factor.

Because of the different internal structure of MicroPython compared to CPython, Python modules developed for CPython in other languages than Python do not work with MicroPython. Pure Python modules work with MicroPython as long as their own dependencies are met. A growing number of libraries is developed by the community. This includes a subset of the standard library useful for microcontrollers, as well as device drivers for different sensors, actuators, displays and other peripheral devices commonly used.

### Editors

Python is widely supported by all general purpose code editors. The two relevant features are syntax highlighting and code completion. Syntax highlighting uses colors to render the codes different components in different styles, helping the developer to better navigate its structure. Code completion provides the programmer with suggestions while typing. These suggestions include the languages keywords, but also variable names that were already used before. This feature reduces the typing work needed and also helps prevent typing errors.

The editor used for all code developed during this project is gedit [@gedit]. It is a simple, yet powerful, graphical text editor. However, given the popularity of Python, all popular editors support it, allowing the developers to chose their tools by personal preference.

### Linting tools

Pylint is the standard linting tool for Python and it can be used for MicroPython as well. It allows to enforce coding standards,for example naming conventions, line length, dead-code detection, and thereby aids readability and maintainability of the code. It also provides error checking which helps addressing the problem of runtime errors in interpreted languages.

Pylint can be configured by the user and thereby allows fine-tuning of the style it enforces. For example, some naming conventions common in the microcontroller world, like naming registers in all caps, are not compliant with the style standard commonly used by desktop Python programmers. By modifying Pylint's configuration file, the enforced style can be adapted to the programming domain.

### Static type checking

Python is a dynamically typed language, which also creates the risk of runtime errors. Mypy is a tool providing static type checking using type hints that are allowed in the Python syntax [@mypy]. In MicroPython, these type hints can even be used to compile functions to native assembler code, providing better performance.

Adding type hints is a straightforward process. The example below defines a function that takes a value and divides it by 2.

~~~{.python}
def spam(n):
    return n / 2.0
~~~

By defining ```n: int```, mypy knows that the input has to be an integer. The return type is indicated as ```float``` using the arrow symbol: ```->```.

~~~{.python}
def spam(n: int) -> float:
    return n / 2.0
~~~

Running mypy on Python code files outfitted with these type hints checks if there are occurrences in the code where other types are used. For example, if ```spam``` is called with a float instead of an integer as argument, it emits a warning. Similarly, if the return value of ```spam``` is assigned to a variable that is type hinted as integer, triggers a waning, too.

Mypy started as extension to Python that introduced incompatible syntax. Mypy code had to be translated back to standard Python code to be run with a Python interpreter. However, feedback was so positive, that an official syntax for type hints was introduced to Python. They are now a native part of the syntax and are being used more and more.

### Flashing, communication and debugging tools

For practical working with MicroPython on a microcontroller only the most basic tools are needed: a text editor and a serial terminal. Source code can be directly copied onto the microcontroller storage, which, when connected to a computer with a USB cable, acts as a \\gls{MSD}. The code copied onto the storage is then compiled to bytecode on the microcontroller itself and is executed. Using a serial terminal application, a \\gls{REPL} can be accessed, allowing to interactively type in code that gets executed by the microcontroller. The usual debugging cycle of microcontroller programming (write $\\rightarrow$ compile $\\rightarrow$ flash$\\rightarrow$ run) is drastically shortened to just write and run.

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

In this workflow, no flashing tool is needed - getting a script on the microcontroller means simply copying a text file to a \\gls{MSD}. Communication happens via a serial terminal and so does debugging. The \\gls{REPL} allows to interact directly with interpreter session, so no introspection tools are needed.

### Documentation tools

Documentation in Python utilizes docstrings. These are special comments that get parsed by the interpreter and accessed from within it using the ```help()``` function. MicroPython does support the docstring syntax, however does not make them available in the interpreter, but rather discards them to save storage and memory.

The docstrings are still useful for generating static documentation and various tools are available to do so. Sphinx is a popular option that is able to create documentation in HTML, Latex and other formats [@sphinx]. Like all other tools that support Python, it can also be used for MicroPython.

\\ \\

When it comes to tools, MicroPython profits from implementing the widely used Python language. Most tools available for Python work just as good with MicroPython. Multiple choices are available for all types of tools and the quality is good among all of the popular ones. MicroPython's nature as interpreter running directly on the microcontroller also makes working with it simple and easy. Any Linux distribution already has all necessary tools to get started pre-installed, and all other platforms also have those tools readily available.

Programming Language Evaluation
-------------------------------

### Readability

* Simplicity  
    A languages simplicity can not be easliy measured, but certain metrics can be used to judge. The number of keywords, reserved words that have special meaning in a language, can be used to compare a languages size. Table \\ref{tab:kw} shows Python and C on the lower end of the scale with around 30 keywords, while C++ and Java use significantly more. Languages that go way below the 30 keyword range usually are special cases. Smalltalk for example uses just 6 keywords, with noting that compares to an ```if```, ```while``` or numerous others common primitives. Instead these are provided by a standard library.

    Table: Number of reserved keywords \\label{tab:kw}

     language             Smalltalk   Go   C    Python   Java   JavaScript   C++
    -------------------- ----------- ---- ---- -------- ------ ------------ -----
     number of keywords   6           25   32   33       50     64           82

    A different metric is feature multiplicity. In the Zen of Python [@pyzen], a set of design principles for the Python language, this is addressed by the statement: "There should be one -- and preferably only one -- obvious way to do it.".
    Lastly, Python does allow for operator overloading. In combination with the type system this has many benefits, as it allows operators to have specific meaning for specific types, but also can lead to confusion when an operator does not do what the programmer expects it to do. However, this is usually a sign that the wrong type is used or that the implementation of the type is wrong.

    Overall it can be said that simplicity is a strength of Python. It has a small, but not minimalist set of keywords and the design philosophy explicitly states goals that target simplicity:

    > Simple is better than complex. [@pyzen]

* Orthogonality  
    Having a small set of primitives that can combined to form large programs, Python adheres to the basic idea of orthogonality. The aim of preferably having one way to do things drives the language to be orthogonal, however there are limits to the concept. A fully orthogonal language in the mathematical sense for example would not have any datatypes beyond the bit, as any other datatypes can be derived from this atomic type. The practicality of that is debatable.

* Data types  
    Python provides a rich set of built-in data types. The numeric types are ```int```, ```float``` and ```complex```, the sequence types are ```list``` and ```tuple``` as well as the text sequence ```str```. There are binary types, ```bytes``` and ```bytearray``` and a boolean type, ```bool```, as well as a mapping type, ```dict```. Furthermore the object oriented features of Python allow to create classes with which the type system can be expanded.

* Syntax design  

    > Readability counts. [@pyzen]

    With readability as an explicitly stated design goal, the syntax design of Python is crafted to make the language simple to read and understand. The language often reads similar to natural language and is described by many programmers as "executable pseudo-code".

### Writability

* Support for abstraction  
    Python supports abstraction well and allows using the object-oriented programming paradigm. There is no concept of public and private, following the philosophy of abstracting complexity, but not hiding implementation details.

* Expressiveness  
    Expressiveness is a clear strength of Python, empirical studies have found that implementing the same requirements in Python yield significant less lines of code than for example in C [@codecomp].

### Reliability

* Type checking  
    Python is dynamically typed and interpreted language and as such type checking is not done by default before the program is run. For example, when a float values is assigned to a variable that was an integer before, it will simply become a float. When an operation is used on a data type that does not support it, an exception raised at runtime when the error is encountered the first time. Type checking can be done manually by using the ```type``` function which returns a variables type, or the exceptions can be handled using the ```try - except``` mechanism. In order to have static type checking, like compiled languages, tools can be used which are described in the toolchain section \\ref{sec:tools}.

* Exception handling  
    Python provides sophisticated exception handling via the ```try - except``` mechanism.

* Restricted aliasing  
    Python does not restrict aliasing in any way, so code linting tools as described in the toolchain section \\ref{sec:tools} have to be used.

### Survey

A first run of the survey was conducted with nine participants. Due to
the small sample size, no definite conclusions can be drawn, still the
results show a pattern worth investigating.

A bar plot can be seen in Figure \\ref{fig:bars}. The mean times spent on each
example per language show that the Python examples where generally
processed quicker. A big standard deviation is present for which two
reasons are already known: Firstly, the prior knowledge is not yet
considered in the analysis. Secondly, the survey participants where not
told that the time spent on each example is measured, as to not induce
stress. However, their smartphones were also not taken from them and
thus posed a distraction. Participants would pause work on the example
to response to messages, which renders the time measurement invalid.
Both issues can be addressed by advanced data analysis, but only fixed
by increasing the sample size.

![Mean of times spend on each example implementation with standard
deviation.\\label{fig:bars}](../language_survey/results/praktikum/results_merged.png){ width=75% }

Figure \\ref{fig:pixels} shows all results at once and compares the time spent
on C examples to times spend on Python examples using a color scale. The
overall green color indicates that Python examples were mostly concluded
faster than C examples.

![Relative time spent on each example by each participant per
language.\\label{fig:pixels}](../language_survey/results/praktikum/map.png){ width=75% }

In summary, the Programming Language Evaluation shows that Python has its strengths in the usability realm of readability and writability, while reliability has to be improved by using external tools. With the readability criteria being the base for all language traits, Pythons strength there can alleviate weaknesses in other areas.

Project-Based Programming Language Evaluation
---------------------------------------------

<#include "Results_Project_Eval.md">

Toolchain Analysis \\label{sec:tools}
------------------

A MicroPython interpreter exists for Linux on ARM as well as for
microcontrollers using ARM Cortex M series or Tensilica cores. A full
implementation and documentation of the Hardware API only exists for the
STM32F4 family of microcontrollers from STMicroelectronics and the
ESP8266 microcontroller. Currently, API implementations for Atmel SAMD21
as well as Kinetics MK20DX are being developed. Porting is generally
possible to all platforms for which a C compiler is available and that
have sufficient storage and memory, the main challenge being the
implementation of the Hardware API.

MicroPythons project structure and build system allow for easy
modification of the interpreter, as well as addition of custom modules,
and can be compiled with a fully Open Source toolchain. However the
internal C API is not officially documented. Some examples and
information are provided by the community, but the missing documentation
is a clear weakpoint, as the possibility to customize and extend and the
simplicity with which this can be done is a key factor.

Because of the different internal structure of MicroPython compared to
CPython, Python modules developed for CPython in other languages than
Python do not work with MicroPython. Pure Python modules work as long as
their own dependencies are met.

As MicroPython adheres to the Python syntax, all Python tools can be
used. This includes syntax highlighting in editors as well as code
linting tools like Pylint. Pylint allows to enforce coding standards,
for example naming conventions, line length, dead-code detection, and
thereby aids readability and maintainability of code. It also provides
error checking which helps addressing the problem of runtime errors in
interpreted languages.

Python is a dynamically typed language, which also creates the risk of
runtime errors. Mypy is a tool providing static type checking using type
hints that are allowed in the Python syntax. In MicroPython, these type
hints can even be used to compile functions to native assembler code,
providing better performance.

For practical working with MicroPython on a microcontroller only the
most basic tools are needed: a text editor and a serial terminal. Source
code can be directly copied onto the microcontroller storage, which,
when connected to a computer with a USB cable, acts as a Mass Storage
Device (MSD). The code copied onto the storage then gets compiled to
bytecode on the microcontroller itself and is executed. Using a serial
terminal application a read–eval–print loop (REPL) can be accessed,
allowing to interactively type in code that gets executed by the
microcontroller. The usual debugging cycle of microcontroller
programming (write $\\rightarrow$ compile $\\rightarrow$ flash
$\\rightarrow$ run) is drastically shortened to just write and run.

Example Implementations
-----------------------

The example implementations were developed using a Raspberry Pi acting
as CDH and a Pyboard acting as the ADCS subsystem. Figure \\\ref{sys} 
shows a simplified overview of the system. The UNIX part of the software
developed on the Raspberry Pi also works on the actual CDH hardware, the
microcontroller counterpart on the Pyboard however does not run on the
real ADCS boards. The ADCS subsystem uses ATXMEGA microcontrollers with
an 8-bit architecture which is not suitable to run MicroPython.

As the ADCS subsystem daemon uses D-Bus and SPI for communication and
those libraries are not available for the targeted platform, the first
step is to implemented those.

![Schematic overview of the system. A Raspberry Pi running Linux an the
UNIX port of MicroPython is connected to a Pyboard via SPI
[@pi][@tux][@upyl].\\label{sys}](resources/figs/sys.png){ width=75% }

<#include "Results_D-bus_Library.md">

<#include "Results_SPI_Library.md">

### ADCS Daemon

Using the MicroPython D-bus and SPI libraries, a re-implementation of
the ADCS subsystem daemon is possible. Because the original C version of
this daemon is currently under heavy development and unfinished, a
stable subset of its functionality was extracted to define a target for
the re-implementation.

In a first step, the C data structures used in the original daemon are
recreated in Python. There are two structures:

-   `control` is used by the daemon to send data to the subsystem which
    controls its functions. For example, the `mode` byte controls the
    operating mode of the subsystem.

-   `data` is populated with sensor data and state information from
    the subsystem.

The structure definitions can not be shared across the languages, which
means that two versions of the definition have to be maintained. Any
differences in the definitions lead to broken data, making this a
serious source of error for all systems where MicroPython has to
communicate with C via such data structures. This problem can be
addressed in two ways: Either by creating a tool that can translate the
definitions between the languages or a tool that can automatically test
the two structures against each other.

In the next step, the D-Bus interface is defined by creating the
function bodies and register them to the bus. Then the actual
functionality can be implemented. For this, the SPI library is used to
transfer the data structures between the CDH and the ADCS subsystem.

In it’s current form the C implementation of the daemon results in a
binary with a size of 100 kB. The MicroPython implementation depends on
the MicroPython interpreter, including the D-bus and SPI library, with a
size of 350 kB in total. The Python code itself is 3 kB in size.

Comparing the length of the implementations, the C version with about
160 lines of code is significantly longer than the 80 line Python
version. The Python version provides the same functionality as the
original while being shorter, requiring less boilerplate code and being
more readable.

### BMX055 Sensor Driver

<#include "Results_BMX_Driver.md">

### Sensor Fusion

<#include "Results_Sensor_Fusion.md">

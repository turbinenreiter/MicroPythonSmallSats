Programming Language Evaluation
-------------------------------

### Readability

* Simplicity  
    A language's simplicity can not be easily measured, but certain metrics can be used to judge it. The number of keywords, reserved words that have special meaning in a language, can be used to compare a language's size. Table \\ref{tab:kw} shows Python and C on the lower end of the scale with around 30 keywords, while C++ and Java use significantly more. Languages that go way below the 30 keyword range usually are special cases. Smalltalk, for example, uses just 6 keywords, with noting that compares to an ```if```, ```while``` or numerous others common primitives. Instead these are provided by a standard library.

    Table: Number of reserved keywords \\label{tab:kw}

     language             Smalltalk   Go   C    Python   Java   JavaScript   C++
    -------------------- ----------- ---- ---- -------- ------ ------------ -----
     number of keywords   6           25   32   33       50     64           82

    A different metric is feature multiplicity. In the Zen of Python, a set of design principles for the Python language, this is addressed by the statement: "There should be one -- and preferably only one -- obvious way to do it" [@pyzen].

    Lastly, Python does allow for operator overloading. In combination with the type system this has many benefits, as it allows operators to have specific meaning for specific types, but also can lead to confusion when an operator does not do what the programmer expects it to do. However, this is usually a sign that the wrong type is used or that the implementation of the type is wrong.

    Overall it can be said that simplicity is a strength of Python. It has a small, but not minimalist set of keywords and the design philosophy explicitly states goals that target simplicity: "Simple is better than complex" [@pyzen].

* Orthogonality  
    Having a small set of primitives that can be combined to form large programs, Python adheres to the basic idea of orthogonality. The aim of preferably having one way to do things drives the language to be orthogonal, however, there are limits to the concept. A fully orthogonal language in the mathematical sense for example would not have any datatypes beyond the bit, as any other datatypes can be derived from this atomic type. The practicality of that is debatable.

* Data types  
    Python provides a rich set of built-in data types. The numeric types are ```int```, ```float``` and ```complex```, the sequence types are ```list``` and ```tuple``` as well as the text sequence ```str```. There are binary types, ```bytes``` and ```bytearray``` and a boolean type, ```bool```, as well as a mapping type, ```dict```. Furthermore the object-oriented features of Python allow to create classes with which the type system can be expanded.

* Syntax design  

    With readability as an explicitly stated design goal, the syntax design of Python is crafted to make the language simple to read and understand: "Readability counts" [@pyzen].

    By using indentation to delimit code blocks and eschewing the use of semicolons to end statements the language reduces line noise and allows to focus on the code instead.

### Writability

* Support for abstraction  
    Python supports abstraction well and allows using the object-oriented programming paradigm. There is no concept of public and private, following the philosophy of abstracting complexity, but at the same time not hiding implementation details.

* Expressiveness  
    Expressiveness is a clear strength of Python. Empirical studies have found that implementing the same requirements in Python yield significant less lines of code than for the same examples implemented in C [@codecomp]. The examples in Section \\ref{sec:ex} also confirm this.

### Reliability

* Type checking  
    Python is a dynamically typed and interpreted language and as such, type checking is not done by default before the program is run. For example, when a float values is assigned to a variable that was an integer before, it will simply become a float. When an operation is used on a data type that does not support it, an exception is raised at runtime when the error is encountered for the first time. Type checking can be done manually by using the ```type``` function which returns a variables type, or the exceptions can be handled using the ```try - except``` mechanism. In order to have static type checking, like compiled languages, tools can be used which will be described in the toolchain section \\ref{sec:tools}.

* Exception handling  
    Python provides sophisticated exception handling via the ```try - except``` mechanism. It allows reacting differently for different exception types and performing clean-up routines before returning via the ```finally``` expression.

* Restricted aliasing  
    Python does not restrict aliasing in any way, so code linting tools as described in the toolchain section \\ref{sec:tools} have to be used.

### Survey

A first run of the survey was conducted with nine participants. Due to
the small sample size, no definite conclusions can be drawn, still the
results show a pattern worth investigating.

A bar plot can be seen in Figure \\ref{fig:bars}. The mean times spent on each
example per language show that the Python examples where generally
processed quicker. A big standard deviation is present for which two
reasons are already known. Firstly, the prior knowledge is not yet
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

\\ \\

In summary, the Programming Language Evaluation shows that Python has its strengths in the usability realm of readability and writability, while reliability has to be improved by using external tools. With the readability criteria being the base for all language traits, Python's strength there can alleviate weaknesses in other areas.

Project-Based Programming Language Evaluation
---------------------------------------------

<#include "Results_Project_Eval.md">

Toolchain Analysis \\label{sec:tools}
------------------

<#include "Results_Toolchain.md">

Example Implementations \\label{sec:ex}
-----------------------

The example implementations were developed using a Raspberry Pi acting as CDH and a Pyboard acting as the \\gls{ADCS} subsystem. Figure \\ref{sys}  shows a simplified overview of the system. The UNIX part of the software developed on the Raspberry Pi also works on the actual \\gls{CDH} hardware, the microcontroller counterpart on the Pyboard, however, does not run on the real \\gls{ADCS} boards. The \\gls{ADCS} subsystem uses ATXMEGA microcontrollers with an 8-bit architecture which is not suitable to run MicroPython.

![Schematic overview of the system. A Raspberry Pi running Linux and the UNIX port of MicroPython is connected to a Pyboard via SPI [@pi][@tux][@upyl].\\label{sys}](resources/figs/sys.png){ width=75% }

As the \\gls{ADCS} subsystem daemon uses D-Bus and \\gls{SPI} for communication and those libraries are not available for the targeted platform, the first step is to implement those.

<#include "Results_D-bus_Library.md">

<#include "Results_SPI_Library.md">

### ADCS Daemon

Using the MicroPython D-Bus and \\gls{SPI} libraries, a re-implementation of the \\gls{ADCS} subsystem daemon is possible.
Figure \\ref{fakesat} shows the development hardware used to test the C version of the daemon. Here, the gls\\{CDH} is emulated by a Beaglebone Black and the real \\gls{ADCS} main and side panels are used. The choice to work on different hardware for this thesis was taken to not interfere with the development process of the flight software. Given the strict timeframe for development of MOVE-II, I could not block the hardware by running tests not directly related to the actual project.

![The development hardware for the C version of the daemon.\\label{fakesat}](resources/figs/fakesat.jpeg){ width=75% }

The resulting software however, both the C any Python versions, are able to run on the Raspberry Pi, Beaglebone Black and original \\gls{CDH} hardware with no differences.

Because the original C version of this daemon is currently under heavy development and unfinished, a stable subset of its functionality was extracted to define a target for the re-implementation.

In a first step, the C data structures used in the original daemon are recreated in Python. There are two structures:

-   `control` is used by the daemon to send data to the subsystem which controls its functions. For example, the `mode` byte controls the operating mode of the subsystem.

-   `data` is populated with sensor data and state information from
    the subsystem.

The structure definitions can not be shared across the languages, which means that two versions of the definition have to be maintained. Any differences in the definitions lead to broken data, making this a serious source of error for all systems where MicroPython has to communicate with C via such data structures. This problem can be addressed in two ways: either by creating a tool that can translate the definitions between the languages or a tool that can automatically test the two structures against each other.

In the next step, the D-Bus interface is defined by creating the function bodies and registering them to the bus. Then, the actual functionality can be implemented. For this, the SPI library is used to transfer the data structures between the CDH and the ADCS subsystem.

In its current form the C implementation of the daemon results in a binary with a size of about 100 kB. The MicroPython implementation depends on the MicroPython interpreter, including the D-bus and SPI library, with a size of about 350 kB in total. The Python code itself is approximately 3 kB in size.

Table \\ref{tab:scd} shows size and complexity measures of the two examples.

Table: Size and complexity comparison \\label{tab:scd}

Language    Filename          LOC    Number of Tokens       CC
----------  --------------  -----  ------------------  -------
Python      adcsdaemon.py     103                 712  2
C++         adcsdaemon.cpp    216                1406  3.2

Comparing the length of the implementations, the C version is about about twice as long as the Python version. The Python version provides the same functionality as the original while being shorter, requiring less boilerplate code and being more readable. The \\gls{CC} is also reduced in the Python version. This reduction can mostly be attributed to the simplified and reduced error handling the language enables, as well as the higher abstraction level of the MicroPython D-Bus library when compared to the sd-bus library used in C.

### BMX055 Sensor Driver

<#include "Results_BMX_Driver.md">

### Sensor Fusion

<#include "Results_Sensor_Fusion.md">

In order to evaluate MicroPython for CubeSats, different strategies are
applied: a language evaluation based on Sebesta [@sebesta], a
project-based evaluation based on Howatt [@howatt], an analysis of the
available programming tools and the comparison of example
implementations. The evaluation happens within the MOVE-II CubeSat
project, ensuring that the examples are realistic and within the domain
of satellite development.

Programming Language Evaluation
-------------------------------

This evaluation focuses on the classic language evaluation criteria
described by Sebesta [@sebesta]. While readability can be analyzed by using the evaluation criteria, it can also be tested. To do so, a survey was created to compare the readability of the Python programming language with C.

The survey consists of nine examples, each with an implementation in
Python and C. The participants are asked to answer questions regarding
each implementation and the time spent on each question is measured. The
comparison of times spent on the implementations of each example can
then be compared to judge the readability of the code snippet. As each
participant sees each example twice, once for each language, two
versions of the survey were produced, with the order of the example
implementations switched. A self assessment of the proficiency in the
languages is asked beforehand, alongside some demographic data.

The response time and the quality of the answers can be used to compare the two example languages readability. The answers can also surface usability problems, in case common errors are found.

![Screenshot of the user interface for the survey. \\label{fig:survey}](resources/figs/survey.png){ width=75% }

Project-Based Programming Language Evaluation
---------------------------------------------

The project-based evaluation tries to implement the proposed strategy
described by Howatt [@howatt]. To do so, a set of criteria originating
from the needs of the development of the Attitude Determination and
Control (ADCS) subsystem daemon for the MOVE-II CubeSat is established.
The ADCS uses magnetometers, gyroscopes and sun sensors to determine the
CubeSats attitude. Magnetorquers are used to create magnetic fields
acting against the earths magnetic field, allowing to stabilize the
satellite and point the antenna towards the ground. The ADCS consists of
a mainpanel with the main microcontroller, four sidepanels and a
toppanel. Each panel has a coil to generate the magnetic field, sensors
and a secondary microcontroller. The mainpanel microcontroller controls
the other panels and is itself controlled by the Command and Data
Handling Unit (CDH). The CDH has a microprocessor running a Linux based
operating system. The ADCS subsystem daemon runs on the CDH and enables
controlling the functions of the ADCS subsystem by exposing D-bus
methods. D-bus is an interprocess communication (IPC) system, providing
a mechanism allowing applications to transfer information and request
services [@dbus]. These are either called by the on-board control
program or remotely via the S-band communications link. The
communication between the ADCS daemon and the ADCS subsystem is done via
SPI.

Toolchain Analysis
------------------

Programming tools can support developers in writing software and help to
enforce quality standards, especially in complex projects with multiple
developers. The availability and quality of such tools and resources for
MicroPython is analyzed.

Example Implementations
-----------------------

Different examples are taken from the MOVE-II source code and are
re-implemented in Python. The two implementations are then compared in
terms of complexity, error rate and performance. In cases where a
missing library has to be implemented, the workload of doing so is also
analyzed. Furthermore, the creation of performance optimized libraries
for Python which are written in C is explored.

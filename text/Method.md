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
described by Sebesta [@sebesta]. First, I look at how Python relates to the different criteria. Where applicable, I compare it to other languages, in other cases I use the language's design philosophy [@pyzen] or documentation [@pydoc].

Besides using the evaluation criteria, readability can also be tested. To do so, I created a survey to compare the readability of the Python programming language with C. C was chosen as baseline over C++ due its smaller number of keywords. While both languages are similar, C++ adds functionality that can be overwhelming in a survey setting. The used examples are short and do not extensivly show Python's object-oriented features, but rather the procedural style. This allows the compared examples to be as similar as possible while being in different languages, ensuring that the differences are caused by the language rather than the programming paradigm or style. At the same time, the examples can stay true to the language's idiom instead of being forced into an alien style.

The survey consists of nine examples, each with an implementation in
Python and C. The participants are asked to answer questions regarding
each implementation and the time spent on each question is measured. The
comparison of times spent on the implementations of each example can
then be compared to judge the readability of the code snippet. As each
participant sees each example twice, once for each language, two
versions of the survey were produced, with the order of the example
implementations switched. A self-assessment of the proficiency in the
languages is asked beforehand, alongside some demographic data.

The participants use a web-based user interface, shown in Figure \\ref{fig:survey} to complete the survey. The code is hidden until the Start-Button is clicked. This also triggers a timer that measures the time until the Done-Button is clicked after the participant has completed their answer in the textbox.

![Screenshot of the user interface for the survey. \\label{fig:survey}](resources/figs/survey.png){ width=75% }

The response time and the quality of the answers can be used to compare the two example languages' readability. The answers can also surface usability problems, in case common errors are found.

Project-Based Programming Language Evaluation
---------------------------------------------

The project-based evaluation tries to implement the proposed strategy described by Howatt [@howatt]. To do so, I established a set of criteria originating from the needs of the development of the \\gls{ADCS} subsystem daemon for the MOVE-II CubeSat.

The \\gls{ADCS} uses magnetometers, gyroscopes and sun sensors to determine the CubeSats attitude. Magnetorquers are used to create magnetic fields acting against the earth's magnetic field, allowing to stabilize the satellite and point the antenna towards the ground. The \\gls{ADCS} consists of a mainpanel with the main microcontroller, four side panels and a top panel. Each panel has a coil to generate the magnetic field, sensors and a secondary microcontroller. The main panel microcontroller controls the other panels and is itself controlled by the \\gls{CDH} unit. The \\gls{CDH} has a microprocessor running a Linux-based operating system. The \\gls{ADCS} subsystem daemon runs on the \\gls{CDH} and enables controlling the functions of the \\gls{ADCS} subsystem by exposing D-bus methods. D-bus is an interprocess communication (IPC) system, providing a mechanism allowing applications to transfer information and request services [@dbus]. These are either called by the on-board control program or remotely via the S-band communications link. The communication between the \\gls{ADCS} daemon and the \\gls{ADCS} subsystem is done via SPI.

The team working on the \\gls{ADCS} software scored the different languages according to the criteria as well as the criteria's importance. The scoring is relative, not absolute and also subjective to the team members. This subjectivity however is allowed in the case of a _project_-based evaluation: a project not only includes the projects goals, but also the team working on it, the facilities, the time-frame and the whole environment in which the project is done. Therefore, an evaluation specific to a project is also specific to a team.

Toolchain Analysis
------------------

Developers use programming tools as support for writing software. Tools can help to enforce style-guides, especially in complex projects with multiple developers, ensure that quality standards are met and facilitate finding and fixing errors through debugging. They can automate important tasks like testing and documentation, which often enables having up-to-date and accurate documentation in the first place.

The availability and quality of such tools and resources for
MicroPython is analyzed by identifying and testing them in practice.

Example Implementations
-----------------------

Different examples are taken from the MOVE-II source code and are
re-implemented in Python. The two implementations are then compared in
terms of complexity, error rate and performance. In cases where a
missing library has to be implemented, the workload of doing so is also
analyzed. Furthermore, the creation of performance optimized libraries
for Python which are written in C is explored.

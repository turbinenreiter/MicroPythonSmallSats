This chapters details the background and theoretical foundation of this work. It first describes the Python programming language and the MicroPython implementation. Then, existing programming language evaluation strategies are described and their applicability is analyzed. Finally, code metrics that can be used to compare a source codes complexity are introduced.

The Python Programming Language and the MicroPython Implementation
------------------------------------------------------------------

Python is an interpreted, object-oriented, high-level programming language with dynamic semantics created by Guido van Rossum. It features high-level data structures and dynamic typing, which makes it attractive for rapid development and as scripting or glue language to connect existing software components. Python’s syntax is designed to aid readability, making it easy to learn and reducing the cost of software maintenance. It supports modules and packages, which encourages program modularity and code reuse [@py]. The Python interpreter and the extensive standard library are released under the Python Software Foundation License, a BSD-style permissive free software license compatible with the GNU General Public License [@pylic].

The reference implementation of this language is called CPython. It is an interpreter and itself written in C. Other implementations with different goals exist, for example Jython, written in Java to target the Java virtual machine, or PyPy, written in a subset of Python and aimed at improving performance. MicroPython is an implementation of Python for microcontrollers and constrained systems, created by Damien George. It aims to be lean and efficient and includes only a small subset of the standard library [@upy]. The source code is published under the permissive MIT license.

The CPython interpreter for the UNIX platform has a size of about 4.7 MB, the MicroPython equivalent has 0.5 MB. CPython’s start-up memory usage is approximately 100 kB, MicroPython’s is 20 kB. Similarly, in CPython object size is large – a simple integer takes 24 bytes in comparison to 4 bytes for 32-bit architectures in MicroPython. Some of this size savings come from the reduced subset of the Python standard library, which also shows a path for further size reduction. MicroPython can be configured at compile time, making it possible to strip out unused parts to reduce the size. Furthermore, the byte-code compiler and the byte-code virtual machine can be separated, so only the size of the byte-code interpreter is relevant to the system. For space systems, the split of byte-code compiler and byte-code interpreter also reduces the amount of software that has to be flight approved, as only the interpreter would run on the spacecraft.

The MicroPython port for microcontroller architectures has an even lower storage and memory footprint: 256 kB of storage and 32 kB of memory are sufficient to run non-trivial programs.

The \\gls{ESA} project of porting MicroPython to the LEON platform performed by George Robotics Ltd. [@ESAupy] has shown that the implementation can run on hardware designed for space. During this project, several improvements were made that further aid the suitability of MicroPython for space applications:

* the separation of bytecode-compiler and interpreter, including the creation of a MicroPython cross compiler that allows to compile MicroPython code on a developer machine that can be deployed on the target machine
* optimizations to reduce the use of the dynamic heap memory, allowing to run programs with a locked heap to ensure a program is deterministic
* integration of MicroPython with RTEMS, a \\gls{RTOS} used by \\gls{ESA}

Given the work done by \\gls{ESA}, this thesis focuses on an language evaluation under practical conditions, emphasizing the usability of the language and tools.

Programming Language Evaluation
-------------------------------

In order to evaluate and compare programming languages, a set of criteria is needed by which to judge them. A canonical set of such is described by Sebesta [@sebesta] and reproduced in Table \\ref{tab:PLEC} and the following section.

The language criteria influence three main traits of a programming language: readability, writability and reliability. These traits are further detailed below, with examples where applicable. These examples are written in pseudo-code to allow for better demonstration of the principles while not looking into specifics of any language.

Table: Language Evaluation Criteria \\label{tab:PLEC}

Characteristic            Readability   Writability   Reliability 
------------------------ ------------- ------------- -------------
Simplicity                     •             •             •      
Orthogonality                  •             •             •      
Data types                     •             •             •      
Syntax design                  •             •             •      
Support for abstraction                      •             •      
Expressiveness                               •             •      
Type checking                                              •      
Exception handling                                         •      
Restricted aliasing                                        •      

### Readability

Readability describes the ease with which a program can be *read*
and understood. In the software life cycle, maintenance is the costliest
factor and outranks design and development. Readability is a key factor
in improving a software’s maintainability and also makes it easier to
spot errors in the code. In assessing readability, the problem domain
has to be acknowledged, as different domains lend themselves to
different notations.

The following characteristics contribute to a language's readability:

* __Overall Simplicity__  
    A _large number of basic constructs_ may be overwhelming, resulting in the use of only a subset of the language. If author and reader of a program learned different subsets, the code becomes harder to understand. _Feature multiplicity_, meaning the existence of different ways to perform the same task, also can have adverse effects, as different people default to different styles. These different styles conflict when developers are working on a codebase in a team as it reduces the ability of each programmer to investigate, understand and improve on code written by colleagues. _Operator overloading_ also poses challenges to readability. This technique allows an operator, like +, -, *, etc., to have different meanings in different situations. While this is accepted in some cases, like having + perform addition of integers and float alike, it can get confusing for other data types, like arrays. The following example shows the practical usage of overloading.

    ~~~{.python}
    >>> int(1) + int(1)
    2 # results in an int
    >>> float(1) + float(1)
    2.0 # results in a float
    >>> float(1) + int(1)
    2.0 # results in a float
    >>> [1, 2, 3] + [4, 5, 6]
    [1, 2, 3, 4, 5, 6] # results in a concatenated list
    ~~~

    When adding two lists with a +, the two lists get concatenated. When the user is working on vector mathematics, this can be a pitfall, as one might expect a vector addition instead.

* __Orthogonality__  
    Orthogonality means that a language has a small number of primitive concepts, that can be combined in a defined way to form the program. Every possible combination is allowed and meaningful. The combinations allow a finite set of primitives to form any imaginable program.
    The term orthogonality is borrowed from geometry, where it describes a right angle between two vectors. In computer science, the term is used to describe the property of a language primitive to have no side effects. Two language primitives are considered orthogonal when combining them does not change their behavior.

    As an example, we use the primitives ```list```, ```+```, ```for```, ```in``` to implement a vector addition.

    ~~~{.python}
    >>> [op1 + op2 for op1, op2 in [1, 2, 3], [4, 5, 6]]
    [5, 7, 9] # performs vector addition
    ~~~

    The ```for op in [1, 2, 3]``` construct creates a loop in which the variable ```op``` is set to the n-th element of the list on the n-th iteration through the loop. In this context, orthogonality is given when the following conditions are true.

    * the ```list``` that is iterated over is not changed by doing so
    * the ```for _ in``` construct behaves the same for any data type it is used on, meaning that it does not change its behavior according to it

    The first condition is true for our example. The second, however, shows the limits of the concept: iterating over a data type is only sensible when the data type is a congregation of values. Iterating over a single value does not work and is not allowed. This means that orthogonality as a mathematical concept can be proven or disproven for a programming language, but in a computer science context it is not a binary decision, but a scale.

* __Data Types__  
    Adequate data types as well as means to define new types and data structures greatly enhance readability. For example, without a boolean type, a flag would have to be set as ```0``` or ```1```, while otherwise more expressive keywords like ```false``` or ```true``` can be used. Expanding our example, we see that by using a vector data type, function overloading helps us to achieve vector addition in a more natural way.

    ~~~{.python}
    >>> vector(1, 2, 3) + vector(4, 5, 6)
    vector(5, 7, 9) # performs vector addition
    ~~~

    Independent of the quality of a type system, it can be either static or dynamic. A static type system enforces that the type of variable never changes. This is allowed in dynamically typed languages at the cost of control over memory. In a statically typed language, it classically was not possible to add an element to a list without explicitly increasing the size reserved for it in memory. In dynamic languages this size increase is implicit. This is enabled by the language's automatic memory management, for example by a garbage collector. Some modern languages are combining the benefits of a static type system with the benefits of automatic memory management, allowing to easier achieve dynamic data structures while retaining the low memory profile and speed of static types.

* __Syntax Design__  
    The syntax is the form of the elements of a language and the structure in which they form statements. It defines the way in which the primitives are combined to programs and therefore how the code _looks_, thus having a big influence on readability. An example of a conditional program flow makes clear how syntax visually communicates the logical structure of the code.

    ~~~{.python}
    if argument == 'strong':
        print('believe')
    elif argument == 'weak':
        print('doubt')
    else:
        pass
    ~~~

    In the above example, the syntax uses indentation to separate code blocks. Every line after the ```if``` that has an indentation level which is one step higher than the ```if``` itself, belongs to its conditional block. The example below shows a different form to achieve the same, but using braces instead of indentation.

    ~~~{.python}
    if (argument == 'strong') {
        print('believe')
    } elif (argument == 'weak') {
        print('doubt')
    } else {
        pass
    }
    ~~~

    Note that the visible indentation has no meaning, only the braces are relevant. The indentation is done to aid readability, but could be omitted. The idea of using indentation instead of braces came from the realization that the first thing programmers do in languages that use braces is to define a style guide asking all developers to adhere to a certain style of indentation.

    For syntax design, it is also important to realize that personal taste can play a significant role. The above example "indentation versus braces" is a perfect testament to that. Programmers using braced languages sometimes show huge distaste against indented languages, all the while they perfectly indent their braced code. Meanwhile, users of indented languages dislike braces although they do nothing but add more visual clues to the indentation they already perform, exactly because of the emphasis on the importance of visual clues. The list of objective arguments is tremendously shorter than any typical discussion of the concepts between programmers.

### Writeability

Writeability describes the ease with which a programming language can
be used to create, or *write*, a program that solves a specific problem.
Lesser cognitive load inflicted on the developer by getting the syntax
right allows to concentrate on the correctness of the program logic.
Abstraction and expressiveness also lessen the amount of code to be
written and reviewed.

* __Simplicity and Orthogonality__  
A language's large number of complex constructs can lead to misuse, as the programmer may lack familiarity with all of them. A smaller number of primitives and rules of combining them allows for solving of complex problems without the need to learn a large number of constructs. However, orthogonality can also lead to undetected programming errors, as it may allow for absurd combinations.

* __Support for Abstraction__  
Abstraction allows the use of complicated operations while many of the details are ignored. For example, a complex algorithm can be implemented once and then reused in different parts of the code by simply being called with the right arguments. The person who uses the algorithm does not necessarily have to know, or remember, its inner workings.

* __Expressiveness__  
Expressiveness means the existence of powerful operators that allow for convenient specification of computations. This allows for short programs to have a lot of meaning. The reduced code length benefits maintainability, however expressiveness is related to implicity and explicity. Implicity can shorten a programs source code, but be less readable than the explicit counterpart. This target conflict is further detailed in Section \\ref{sec:metrics} that describes the software metric used to measure code length as well as complexity.


### Reliability

Reliability describes a program's ability to perform its function
under all conditions. Exception handling helps to create programs that
can recover from unforeseen occurrences, type checking ensures the
validity of the input and interfaces.

* __Type Checking__  
Checking for type errors is an important method to avoid program crashes. Checking for type errors before the program is run avoids that those errors can happen later. If this is not done, type errors have to be caught and handled during the programs operation, otherwise the program crashes.

* __Exception Handling__  
Exception handling allows a program to deal with errors during operation without crashing, by identifying them and take corrective measures.

* __Aliasing__  
Aliasing means to assign more than one name to the same memory cell. If one of the aliases is changed, the other one is, too. This can result in errors when the programmer is unaware of a variable being an alias. Thus, it can be detrimental to reliability by creating a pitfall for mistakes by the developer.

* __Readability and Writeability__  
The easier a program is to write and maintain, the less likely errors will happen and they will be easier to find and fix.

### Additional criteria

For space systems, there is another criteria that is not described in the classic Programming Language Evaluation canon: determinism.

* __Determinism__  
Determinism means that the same code leads to the same program with the same results in all conditions. For dynamic languages like Python, determinism is not a given, due to the dynamic allocation of heap memory. When there is not enough memory left to allocate the necessary heap, the same program can fail when it succeed before, despite it not having changed. The program's success becomes depended on the availability of free memory which is in turn depended on the behavior of other programs running on the system.
In MicroPython, this can be addressed by locking the heap, thus disallowing the program to allocate memory. Doing so needs special considerations as to how to write a program. For example, on a locked heap, any lists that are used have to be pre-allocated and can not be appended later. Also, some language primitives allocate on the heap and can not be used when it is locked. Work done in porting MicroPython to the LEON platform [@ESAupy] specifically addresses this by applying improvements that reduce the number of heap-allocating primitives.

\\ \\

The programming language evaluation criteria described in this section allow to assess the general quality and usability of a language. Suitability for specific domains can be deducted by weighing the relative importance of the criteria, but the focus of the method is clearly on evaluating the language, not its suitability for specific tasks.
The criteria also do not allow to objectively rank languages. While some, like orthogonality can at least be objectively measured, others, like syntax design, can only be subjectively assessed. Even for criteria that can be measured, the optimums are debatable. For example, to increase expressiveness, the number of primitives will be higher, thus reducing the perceived simplicity. The relative importance of the possibly conflicting criteria can only be subjectively defined.

Project-Based Programming Language Evaluation
---------------------------------------------

Programming language evaluation criteria, like the ones described above, are based solely on characteristics inherent in a language, but the specific needs of a project are not represented. Therefore, in addition to the classic language evaluation, an evaluation specific to the project is needed [@howatt]. Howatt proposed such an evaluation scheme, but it was never expanded beyond a basic description of the idea, which is reproduced in this section.

The criteria for the project-based evaluation would be defined by the software developers during the specification or architectural phase of a project. These criteria would describe the demands of the specific project on a programming language. The format would include:

* the criterion: a description of the quality to be measured
* the importance of the criterion to the specific project
* the degree to which a language satisfies the criterion

This approach allows to consider the practical details of a project and thereby appends the more theoretical approach of the classic language evaluation. The defined format also forces to reevaluate languages for each project, helping to provide a rational to find the suitable languages, instead of always using the familiar ones. Language familiarity however is explicitly not disregarded as a decisive factor: the benefits of a new language always have to exceed the cost of switching.

Software metrics \\label{sec:metrics}
----------------

Software metrics allow to measure and quantify traits of a programs source code. They provide objective and reproducible statistics about code that can help to analyze it in terms of quality, maintainability and complexity. In this work, they are used to compare example implementations of the same functionality in MicroPython and C/C++. However, one has to be careful in drawing conclusions from them. For example, when using the number of lines of code to determine a programmer's productivity a wrong incentive is given to the programmer. The best work often reduces instead of increases the number of lines of code because shorter, more elegant and less error prone solutions to a problem were found.

### \\glsfirst{LOC}

The simplest code metric is the count of lines of code. In counting lines, ignoring blanks or comments, the size of an implementation can be judged. When comparing two implementations of the same functionality in different languages, their expressiveness can be derived: less LOC solving the same problem indicates a higher expressiveness of the language.
The simplicity of this metric also means that nuances get lost. A good  example is the anti-pattern of magic numbers. Anti-patterns are common bad programming practices, the anti-pattern of magic numbers describes the occurrences of unexplained values in the code. Consider the following (shortened) C example:

~~~{.c}
int raw_value = 0;
float value = 0;
...
value = raw_value / 1024;
~~~

The ```1024``` is a magic number, because we don't know what it is. The example can be rewritten to give the value an explicit name. Depending on whether this value would be constant or variable, this can be done in different ways: the one shown below assumes a constant that is hardcoded at compile time.

~~~{.c}
#define RESOLUTION 1024

int raw_value = 0;
float value = 0;
...
value = raw_value / RESOLUTION;
~~~

The LOC obviously increased by one, but the new solution is more readable and easier to understand. Generally, explicit is more readable than implicit, but implicit is more expressive than explicit.

### \\glsfirst{HCM}

\\gls{HCM} are properties of a program's implementation calculated from a static analysis of the source code. They can be used to compare the complexity of different implementations, also in different languages, of the same functionality [@halstead].

The analysis is based on a simple counting of certain elements of a code:

* the number of distinct operators $n_1$
* the number of distinct operands $n_2$
* the total number of operators $N_1$
* the total number of operands $N_2$

With these, following measures can be calculated:

* The program vocabulary $n$ describes how many distinct primitives were used:
\\begin{equation}
\\label{eq:voc}
n = n_1 + n_2
\\end{equation}

* The program length $N$ describes the length as number of total primitives:
\\begin{equation}
\\label{eq:len}
N = N_1 + N_2
\\end{equation}

* The programs volume $V$:
\\begin{equation}
\\label{eq:vol}
V = N \\cdot log_2 (n)
\\end{equation}

* The difficulty $D$ of writing the program:
\\begin{equation}
\\label{eq:dif}
D = \\frac{n_1}{2} \\cdot \\frac{N_2}{n_2}
\\end{equation}

* The effort $E$ that goes into writing the program:
\\begin{equation}
\\label{eq:ef}
E = D \\cdot V
\\end{equation}

Derived from those measures, the following predictions can be made based on factors that have to be derived from statistics over many large codebases:

* The time $T$ required to write the program:
\\begin{equation}
\\label{eq:t}
T = \\frac{E}{18} s
\\end{equation}

* The number of bugs $B$ to be expected in the program:
\\begin{equation}
\\label{eq:bugs}
B = \\frac{E^{\\frac{2}{3}}}{3000}
\\end{equation}

The \\gls{HCM} uses an extremely simplistic code analysis, counting operators and operands, to derive comparable metrics, which can also be used to make predictions based on past experiences. The metrics can be used to compare the complexity of implementations across languages, but due to the simplicity of the method the results do not translate well into a factor of usability. They heavily reflect program length and expressiveness, both of which are not sufficient to judge readability and writability. Furthermore, the predictions that can be made rely on statistics that are neither readily available nor easy to obtain. For this study, I will completely disregard the predictive measures, as it is not possible in the scope of this work to obtain the data needed to find legitimate and reproducible factors for them.

### \\glsfirst{CC}

\\gls{CC} measures how much decision logic a program contains. It describes how many valid paths through a program exist, which is of special relevance for testing: every possible path has to be tested. These paths are described by a control flow graph. Nodes in this graph describe computational statements, edges represent the transfer of control between nodes. The \\gls{CC} is calculated from the number of nodes $n$, edges $e$ and connected components $p$ as shown in equation \\ref{eq:cc} [@mccabe].

\\begin{equation}
\\label{eq:cc}
CC = e - n + 2 * p
\\end{equation}

The same algorithm implemented in two different programming languages can have a different \\gls{CC} for both:

* a more expressive language needs less statements, reducing the number of nodes
* a dynamic language reduces the number of edges because it doesn't need logic to handle different data types

A language's expressiveness is influenced by its number of keywords. More keywords enable it to provide more specialized functionality, eliminating the need to specialize by combining keywords. In this context, more keywords reduce complexity, which directly conflicts with the criterion of language simplicity.
Like we did in the LOC section before, we again can trace this issue back to the issue of implicity versus explicity and expressiveness. Ultimately, a larger number of specialized keywords decrease complexity by implicity, while a smaller number of more orthogonal keywords increase readability by demanding explicity.

\\gls{CC} allows to judge a program's logical complexity, a comparison across languages can indicate expressiveness. The impact on usability has to be carefully weighed against the other criteria, acknowledging the present target conflicts. There is no direct link between the \\gls{CC} and a language's usability.

\\ \\

The classic software metrics were designed to reason about a program's complexity. In the context of evaluating programming languages, rather than programs, I find them to be mainly useful in comparing expressiveness. This can be used as an aspect in comparing the languages' usability but the target conflict of expressiveness with readability regarding implicity and explicity has to be acknowledged.

## The Python Programming Language and the MicroPython Implementation

Python is an interpreted, object-oriented, high-level programming
language with dynamic semantics created by Guido van Rossum. It features
high-level data structures and dynamic typing, which makes it attractive
for rapid development and as scripting or glue language to connect
existing software components. Python’s syntax is designed to aid
readability, making it easy to learn and reduces the cost of software
maintenance. It supports modules and packages, which encourages program
modularity and code reuse [@py]. The Python interpreter and the
extensive standard library are released under the Python Software
Foundation License, a BSD-style permissive free software license
compatible with the GNU General Public License [@pylic].

The reference implementation of this language is called CPython. It is
an interpreter and itself written in C. Other implementations with
different goals exist, for example Jython, written in Java to target the
Java virtual machine, or PyPy, written in a subset of Python and aimed
at improving performance. MicroPython is an implementation of Python for
microcontrollers and constrained systems, created by Damien George. It
aims to be lean and efficient and includes only a small subset of the
standard library [@upy]. The source code is published under the
permissive MIT license.

The CPython interpreter for the UNIX platform has a size of about 4.7
MB, the MicroPython equivalent has 0.5 MB. CPython’s start-up memory
usage is approximately 100 kB, MicroPythons is 20 kB. Similarly, in
CPython object size is large – a simple integer takes 24 bytes in
comparison to 4 bytes for 32-bit architectures in MicroPython. Some of
this size savings come from the reduced subset of the Python standard
library, which also shows a path for further size reduction. MicroPython
can be configured at compile time, making it possible to strip out
unused parts to reduce the size. Furthermore, the byte-code compiler and
the byte-code virtual machine can be separated, so only the size of the
byte-code interpreter is relevant to the system. For space systems, the
split of byte-code compiler and byte-code interpreter also reduces the
amount of software that has to be flight approved, as only the
interpreter would run on the spacecraft.

The MicroPython port for microcontroller architectures has an even lower
storage and memory footprint: 256 kB of storage and 32 kB of memory are
sufficient to run non-trivial programs.


## Programming Language Evaluation

In order to evaluate and compare programming languages, a set of
criteria is needed by which to judge them. A canonical set of such is
described by Sebesta [@sebesta] and reproduced in Table \\ref{tab:PLEC} and the following section.

The language criteria influence three main traits of a programming
language: readability, writability and reliability. These traits are further detailed below, with examples where applicable. These examples are written in pseudo-code to allow for better demonstration of the principles.

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

The following characteristics contribute to a languages readability:

* __Overall Simplicity__  
    A _large number of basic constructs_ may be overwhelming, resulting in the use of only a subset of the language. If author and reader of a program learned different subsets, the code becomes harder to understand. _Feature multiplicity_, meaning the existence of different ways to perform the same task, also can have adverse effects, as different people default to different styles. _Operator overloading_ also poses challenges to readability. This technique allows an operator, like +, -, *, etc., to have different meanings in different situations. While this is accepted in some cases, like having + perform addition of integers and float alike, it can get confusing for other data types, like arrays. The following example shows the practical usage of overloading.

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

    When adding two lists with a +, the two lists get concatenated. When the user is working on vector mathematics, this can be a pitfall, as she would expect a vector addition instead.

* __Orthogonality__  
    Orthogonality means that a language has a small number of primitive concepts, that can be combined in a defined way to form the program. Every possible combination is allowed and meaningful. The combinations allow a finite set of primitives to form any imaginable program.
    As an example, we use the primitives ```list```, ```+```, ```for```, ```in``` to implement a vector addition.

    ~~~{.python}
    >>> [op1 + op2 for op1, op2 in [1,2,3], [4,5,6]]
    [5, 7, 9] # performs vector addition
    ~~~

* __Data Types__  
    Adequate data types as well as means to define new types and data structures greatly enhance readability. For example, without a boolean type, a flag would have to be set as ```0``` or ```1```, while otherwise more expressive keywords like ```false``` or ```true``` can be used. Expanding our example, we see that by using a vector data type, function overloading helps us to achieve vector addition in a more natural way.

    ~~~{.python}
    >>> vector(1, 2, 3) + vector(4, 5, 6)
    vector(5, 7, 9) # performs vector addition
    ~~~

* __Syntax Design__  
    The syntax is the form of the elements of a language and the structure in which they form statements. It defines the way the primitives are combined to programs and therefore how the code _looks_, thus having a big influence on readability. An example of a conditional program flow makes clear how syntax visually communicates the logical structure of code.

    ~~~{.python}
    if argument == 'strong':
        print('believe')
    elif argument == 'weak':
        print('doubt')
    else:
        pass
    ~~~

    In the above example, the syntax uses indentation to separate code blocks. Every line after the ```if``` that has an indentation level which is one higher than the ```if``` itself belongs to its conditional block. The example below shows a different form to achieve the same, but using braces instead of indentation.

    ~~~{.python}
    if (argument == 'strong') {
        print('believe')
    } elif (argument == 'weak') {
        print('doubt')
    } else {
        pass
    }
    ~~~

    Note that the visible indentation has no meaning, only the braces are relevant. The indentation is done to aid readability, but could be omitted. The idea of using indentation instead of braces came from the realization that the first thing programmers do in languages that uses braces is to do define a style guide asking all developers to adhere to a certain style of indentation.

    For syntax design, it is also important to realize that personal taste can play a significant role. The above example "indentation versus braces" is a perfect testament to that. Programmers using braced languages sometimes show huge distaste against indented languages, all the while they perfectly indent their braced code. Meanwhile, users of indented languages dislike braces although they do nothing but add more visual clues to the indentation they already do. The list of objective arguments is tremendously shorter than any typical discussion of the concepts between programmers.

### Writeability

describes the ease with which a programming language can
be used to create, or *write*, a program that solves a specific problem.
Lesser cognitive load inflicted on the developer by getting the syntax
right allows to concentrate on the correctness of the program logic.
Abstraction and expressiveness also lessen the amount of code to be
written and reviewed.

* __Simplicity and Orthogonality__  
A languages large number of complex constructs can lead to misuse, as the programmer may lack familiarity with all of them. A smaller number of primitives and rules of combining them allows for solving of complex problems without the need to learn a large number of constructs. However, orthogonality can also lead to undetected programming errors, as it may allow for absurd combinations.

* __Support for Abstraction__  
Abstraction allows the use of complicated operations while many of the details are ignored. For example, a complex algorithm can be implemented once and then reused in different parts of the code by simply being called with the right arguments. The person who uses the algorithm does not necessarily have to know, or remember, it's inner workings.

* __Expressiveness__  
Expressiveness means the existence of powerful operators that allow for convenient specification of computations. This allows for short programs to have a lot of meaning.


### Reliability

describes a programs ability to perform its function
under all conditions. Exception handling helps to create programs that
can recover from unforeseen occurrences, type checking ensures the
validity of the input and interfaces.

* __Type Checking__  
Checking for type errors is an important method to avoid program crashes. Checking for type errors before the program is run avoids that those errors can happen later. If this is not done, type errors have to be caught and handled during the programs operation, otherwise the program crashes.

* __Exception Handling__  
Exception handling allows a program to deal with errors during operation without crashing, by identifying them and take corrective measures.

* __Aliasing__  
Aliasing means to assign more than one name to the same memory cell. If one of the aliases is changed, the other one does, too. This can result in errors when the programmer forgets about it and therefore is detrimental to reliability.

* __Readability and Writeability__  
The easier a program is to write and maintain, the less likely errors will happen and they will be easier to find and fix.


These programming language evaluation criteria allows to assess the general quality and usability of a language. Suitability for specific domains can be deducted by weighing the relative importance of the criteria, but the focus of the method is clearly on evaluating the language, not its fitness for specific tasks.
The criteria also do not allow to objectively rank languages. While some, like orthogonality can at least be objectively measured, others, like syntax design, can only be subjectively assessed. Even for criteria that can be measured, the optimums are debatable. For example, to increase expressiveness, the number of primitives will be higher, thus reducing the perceived simplicity. The relative importance of the possibly conflicting criteria can only be subjectively defined.

## Project-Based Programming Language Evaluation

Programming language evaluation criteria, like the ones described above,
are based solely on characteristics inherent in a language, but the
specific needs of a project are not represented. Therefore, in addition
to the classic language evaluation, an evaluation specific to the
project is needed [@howatt]. Howatt proposed such an evaluation scheme,
but it was never expanded beyond a basic description of the idea.

The criteria for the project-based evaluation would be defined by the
software developers during the specification or architectural phase of a
project. These criteria would describe the demands of the specific
project on a programming language. The format would include:

* the criterion: a description of the quality to be measured
* the importance of the criterion to the specific project
* the degree to which a language satisfies the criterion

This approach allows to consider the practical details of a project and
thereby appends the more theoretical approach of the classic Language
Evaluation. The defined format also forces to reevaluate languages for
each project, helping to provide a rational to find the suitable
languages, instead of always using the familiar ones. Language
familiarity however is explicitly not disregarded as decisive factor:
the benefits of a new language always have to exceed the cost of
switching.

## Software metrics

Software metrics allow to measure and quantify traits of a programs source code. They provide objective and reproducible statistics about code that can help to analyze it in terms of quality, maintainability and complexity. However, one has to be careful in drawing conclusions from them. For example when using the number of lines of code to determine a programmers productivity a wrong incentive is given to the programmer. The best work often reduces instead of increases the number of lines of code because shorter, more elegant and less error prone solutions to a problem were found.

### Lines of Code (LOC)

The simplest code metric is the count of lines of code. In counting lines, ignoring blanks or comments, the size of an implementation can be judged. When comparing two implementations of the same functionality in different languages, their expressiveness can be derived: less LOC solving the same problem indicates a higher expressiveness of the language.
The simplicity of this metric also means that nuances get lost. A good  example is the anti pattern of magic numbers. Anti patterns are common bad programming practices, the anti pattern of magic numbers describes the occurrences of unexplained values in the code. Consider the following (shortened) C example:

```{.c}
int raw_value = 0;
float value = 0;
...
value = raw_value / 1024;
```

The ```1024``` is a magic number, because we don't know what it is. The example can be rewritten to give the value an explicit name. Depending on whether this value would be constant or variable, this can be done in different ways, the one shown below assumes a constant that is hardcoded at compile time.

```{.c}
#define resolution 1024

int raw_value = 0;
float value = 0;
...
value = raw_value / RESOLUTION;
```

The LOC obviously increased by one, but the new solution is more readable and easier to understand. Generally, explicit is more readable than implicit, but implicit is more expressive than explicit.

### Halstead complexity (HC)

[@halstead]

### Cyclomatic complexity (CCN)

[@mccabe]


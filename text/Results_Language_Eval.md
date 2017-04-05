### Readability

* Simplicity  
    A language's simplicity can not be easily measured, but certain metrics can be used to judge it. The number of keywords, reserved words which have special meaning in a language, can be used to compare a language's size. Table \\ref{tab:kw} shows Python and C on the lower end of the scale with around 30 keywords, while C++ and Java use significantly more. Languages going way below the 30 keyword range usually are special cases. Smalltalk, for example, uses just 6 keywords, with noting comparable to an ```if```, ```while``` or numerous others common primitives. Instead these are provided by a standard library.

    Table: Number of Reserved Keywords \\label{tab:kw}

     language             Smalltalk   Go   C    Python   Java   JavaScript   C++
    -------------------- ----------- ---- ---- -------- ------ ------------ -----
     number of keywords   6           25   32   33       50     64           82

    A different metric is feature multiplicity. In the Zen of Python, a set of design principles for the Python language, this is addressed by the statement: "There should be one -- and preferably only one -- obvious way to do it" [@pyzen].

    Lastly, Python does allow for operator overloading. In combination with the type system this has many benefits, as it allows operators to have specific meaning for specific types, but also can lead to confusion when an operator does not do what the programmer expects it to do. However, this is usually a sign that the wrong type is used or that the implementation of the type is wrong.

    Overall it can be said that simplicity is a strength of Python. It has a small, but not minimalist set of keywords and the design philosophy explicitly states goals targeting simplicity: "Simple is better than complex" [@pyzen].

* Orthogonality  
    Having a small set of primitives which can be combined to form large programs, Python adheres to the basic idea of orthogonality. The aim of preferably having one way to do things drives the language to be orthogonal, however, there are limits to the concept. A fully orthogonal language in the mathematical sense for example would not have any datatypes beyond the bit, as any other datatypes can be derived from this atomic type. The practicality of that is debatable.

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
    Python is a dynamically typed and interpreted language and as such, type checking is not done by default before the program is run. For example, when a float values is assigned to a variable that was an integer before, it will simply become a float. When an operation is used on a data type which does not support it, an exception is raised at runtime when the error is encountered for the first time. Type checking can be done manually by using the ```type``` function which returns a variables type, or the exceptions can be handled using the ```try - except``` mechanism. In order to have static type checking, like compiled languages, tools can be used which will be described in the toolchain section \\ref{sec:tools}.

* Exception handling  
    Python provides sophisticated exception handling via the ```try - except``` mechanism. It allows reacting differently for different exception types and performing clean-up routines before returning via the ```finally``` expression.

* Restricted aliasing  
    Python does not restrict aliasing in any way, so code linting tools as described in the toolchain section \\ref{sec:tools} have to be used.

### Survey

A first run of the survey was conducted with nine participants. Due to the small sample size, no definite conclusions can be drawn, still the results show a pattern worth investigating.

A bar plot can be seen in Figure \\ref{fig:bars}. The mean times spent on each example per language show that the Python examples where generally processed quicker. A big standard deviation is present for which two reasons are already known. Firstly, the prior knowledge is not uniform and no compensation for it is done in the analysis. Secondly, the survey participants where not told that the time spent on each example is measured, as to not induce stress. However, their smartphones were also not taken from them and thus posed a distraction. Participants would pause work on the example to response to messages, which renders the time measurement invalid. Both issues can be addressed by advanced data analysis, but only fixed by increasing the sample size.

![Mean of times spend on each example implementation with standard
deviation.\\label{fig:bars}](../language_survey/results/praktikum/results_merged.png){ width=75% }

Figure \\ref{fig:pixels} shows all results at once and compares the time spent on C examples to times spend on Python examples using a color scale. The overall green color indicates the Python examples were mostly concluded faster than the C examples.

![Relative time spent on each example by each participant per
language.\\label{fig:pixels}](../language_survey/results/praktikum/map.png){ width=75% }

As the main measurement for this survey is the time, the examples were chosen such, that a high rate of correct answers was likely. Table \\ref{tab:can} shows the rate of correct answers for both languages at about 70%, with C having a small lead on Python.

Table: Rate of Correct Answers\\label{tab:can}

Language    Correct Answers
---------  -----------------
Python      $67.3~\\%$
C           $70.4~\\%$

These results are positive, especially when considering the prior knowledge stated by the participants: all of them stated at least a beginner-level of familiarity with C, with one third stating advanced-level, while only one third reached beginner-level with Python. Two thirds had no prior knowledge of Python at all.

There is, however one example with an especially interesting result:

~~~{.python}
for i in range(0, 3):
    print(i)
~~~

The error rate here was %100~\\%$, while the corresponding C example shown below had an error rate of $0~\\%$.

~~~{.c}
for(i=0; i<3; i++) {
    printf("%d\n", i);
}
~~~

The correct answer for both examples is an output of 0, 1, and 2, but for the Python example all participants answered 0, 1, 2 and 3. At an error rate of 100%, it is safe to say this is a counterintuitive language construct, rather than user error. The reason for this behaviour is the commonly used zero-indexing of lists: the first element in a list has the adress 0, rather than 1. While this is also used in C, Python's ```range``` keyword creates enough confusion to make people get it wrong, even when they know about zero-indexing.

Other examples with unusually high error rates were examples showing errors or undefined behaviour, like accessing an unintialized variable. For both languages, participants expected an error message. For Python this answer is true, but for C, this depends on the used compiler and compiler settings: C allows accessing uinitialized variables, the returned value is whatever the corresponding memory area holds at that moment. The compiler does not issue an error, but only a warning which might not be shown. To avoid such errors, it is advisable to treat warnings as erros, which all C compilers support.

\\ \\

In summary, the Programming Language Evaluation shows that Python has its strengths in the usability realm of readability and writability, while reliability has to be improved by using external tools. With the readability criteria being the base for all language traits, Python's strength there can alleviate weaknesses in other areas.

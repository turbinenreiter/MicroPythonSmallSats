The introduction already gave an overview of the motivation that can be condensed to:

* Software complexity is rising.
* Complexity increases risk of errors.
* Errors lead to mission failure.
* Higher-level programming languages can help manage complexity through better usability.
* Adoption of new methods in the space industry is slow.
* CubeSats provide a chance to experiment without taking big risks.

Derived from that list, the core idea of this study is:

* Use CubeSats as testbed for new programming languages able to address rising software complexity by increased usability.

In this chapter the motivation for this study is detailed by taking a closer look at the aspects mentioned above.

## Rising software complexity and software errors leading to mission failure

## Managing software complexity through higher-level programming languages

## Using CubeSats to drive adoption of new technologies

Programming languages are tools to solve problems. Different problems require different tools and the large number of existing, and also used, languages provide ample resources to find one that fits the task at hand.

However, the choice of language is often severely constricted and the choice is not made by project-based criteria, but organizational ones. The chosen languages are the ones that “have always been used”, that “everyone else uses”, that are already “available for the development system” or that are required in order to “satisfy contractual obligations” [@howatt]. For microcontroller platforms, C and C++ often are the only supported languages. To reasonably use a language on a platform, not only a compiler or interpreter targeting it is needed, but also a HAL, so the microcontrollers peripheral devices can be used. Table \\ref{tab:uclang} shows a non-exhaustive list of languages that can be used on microcontrollers.

Table: Programming Language Availability on Microcontrollers \\label{tab:uclang}

------------------------------------------------------------------------
language          project            availability     HAL                         character
----------------- ------------------ ---------------- --------------------------- ------------------------------
C                 GCC                common           vendor supplied             industry standard

C++               GCC                common           vendor supplied             industry standard

Arduino           Arduino            many             by Arduino project          beginner oriented, widespread

Haskell           haskino            Arduino          via Arduino                 small project

D                 GDC                Cortex-M         none                        experimental

Ada               GNAT               few              few                         usable, commercial compilers available

Rust              LLVM               some             some                        experimental

Python            MicroPython        few              via MicroPython             stable project, good support for few platforms

JavaScript        Espruino           few              via Espruino                stable project, good support for few platforms

Lua               eLua               few              via eLua                    stable project, good support for few platforms
------------------------------------------------------------------------

On this short list, there is only one family of languages with widespread availability and a usable HAL: C, C++ and Arduino, which is a subset of C++. Some smaller projects achieve good availability by piggybacking on the Arduino ecosystem, but suffer from its beginner oriented limitations. Other languages can target microcontrollers by the virtue of their compiler suites, which provide targets for microcontroller architectures, but often lack a HAL.
The MicroPython, Espruino and eLua projects represent a different approach. These project implement small interpreters of the respective languages that can run on microcontrollers. They also provide a HAL for the targeted devices. This means that the number of supported platforms is small, but also, that the provided HAL is consistent across the platforms. In doing so, these projects transcend from being language implementations to being frameworks, and even intersecting with real time operating systems (RTOS).

Because of the special requirements for space systems, and the conservative approach that is common in the space industry, only a small set of languages are actively used. Developers default to known and proven languages for expensive and critical projects, leaving little room for experimentation. This approach slows adoption of new languages and tools, which means that there is possibly a lot of untapped potential to improve the developers' workflow.
CubeSats can provide a way of overcoming the limitations of this conservative approach. They are small, low-cost satellites with standardized dimensions, which enables them to be launched as secondary payloads alongside bigger missions. This severely lowers the launch cost and total cost of getting a satellite to orbit. For innovators, CubeSats are an ideal platform to push new technologies and ideas. Once proven space-ready by a CubeSats mission, a new technology is ready to be adopted in more critical missions.

MicroPython is such a new technology that can potentially be useful for space applications. It is an implementation of the Python programming language designed for constrained systems, like those common in space
computing. Python is a language explicitly designed to aid readability. It has the potential to address the rising complexity of space software systems simply by being easy to use.

First steps towards the use of MicroPython in space have already been
undertaken by an ESA project, motivated by a desire to write the
high-level application software in a language more suited to the
application layer, meaning a high-level language like Python. Compared
to C, Python enables higher productivity, more expressiveness,
higher-level language constructs and inherent language safety. Furthermore, for high-level applications the possibility for updating the software easily and with little risk is desired. This can be done by patching in compiled languages like C, where the complete software is recompiled and either a patch, meaning only the differing parts of the compiled software, is deployed or the software is completely replaced by a new version. Patching poses its own set of risks and is therefore avoided when possible. The use of MicroPython would better allow this flexibility. Instead of recompiling the complete software, only a script that controls the lower level functionality has to be changed [@ESAupy].

With the novel MicroPython implementation enabling Python to be used on constrained systems, its potential benefits and possibilities call for a
detailed evaluation. Given ESA's work on the technical aspects of the implementation, I want to focus more on usability and a practical approach embedded within the MOVE-II CubeSat project.

The goal of this evaluation is to answer the following questions:

* Can MicroPython be used on CubeSats?
* What are the benefits and drawbacks of using MicroPython on CubeSats?

Derived from those goals there is a methodical question to be answered first:

* How can the suitability of a programming language and its implementation for space application be evaluated?

Although in this thesis I focus on the evaluation of MicroPython, the overarching goal is to look for ways to expand the number of languages from which developers of space systems can choose. Being restricted to C means that benefits of other languages can never be used. The problem is not that C is a bad language. It survived for a long time and still dominates for good reasons. It exists in a sweet-spot between being low-level enough to give developers full control and high-level enough to be usable. It is commonly available for all platforms through an Open Source compiler, the GNU Compiler Collection (GCC) [@gcc], and comes with no overhead in regards of performance or size. The caveats of the language come into play when systems get increasingly complex. The language's low-level memory access is prone to programmer error. In software security, memory errors are one of the prime sources of attack vectors on systems. The readability problems slow down debugging and make it harder for different programmers to read and understand each others code.

Other languages exist and persist for good reasons. Higher-level languages, like Python, allow for quicker and easier development on the cost of execution speed. These languages, are easier in use and more forgiving to newcomers. Specialized languages allow to solve specific problems more quickly and save development time and cost.

Given the breadth of programming tasks and available, well-designed languages, being restricted to using just one language is not satisfying. The proposed method for evaluating the suitability of a language for a project therefore aims to be applicable not only to evaluate MicroPython for CubeSats, but any language for any project.
The method uses classic programming language evaluation criteria, as can be found in many textbooks [@sebesta], implements the project-based evaluation method as proposed by Howatt [@howatt] and adds comparisons of example implementations in different languages.

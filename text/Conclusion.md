How can the suitability of a programming language and its implementation for space application be evaluated?
----------------------------------------------------------

The method I propose in this thesis is a practical one:

#. Analyze the language according to the classic language evaluation criteria.
#. With your team, find a project that allows for experimentation. Define project-based language evaluation criteria and score the different languages you are interested in.
#. Implement the project (or parts of it) in the language you want to evaluate and a baseline language to compare against. When possibly use already implemented examples.

To evaluate the space-readiness the project example has to come from a space application. An additional, preceding step is to investigate the language implementation's determinism. It has to be possible to write deterministic programs in a language to be useful for space applications.

This outcome is rather different from what I expected it to be. Space seemingly has a unique set of requirements on the systems designed to operate there, but for software they end up to be very much the same as on earth: it has to run reliable, be easy to write and cheap to maintain. Many of the harsh environmental influences on space systems are not addressable in a programming language. A programming language can not compensate for radiation events like bitflips or latch-ups. These things can be addressed by radiation proof hardware, lockstep dual-cores and special software, like fault tolerant file-systems. The language this software is written in does not matter to the functionality.
Other requirements, like the memory, storage and performance restrictions, however, do limit the use of language to those which allow for small size and efficiency. But these traits are traits of the implementation, not necessarily the language. For example, the Python language has implementations that address the storage and memory constraints, MicroPython, and also the performance constraints, PyPy.

When a language implementation is found that can run on the target platform, the method described in this thesis allows to evaluate if it can be used for the specific project. The third step of this method, the implementation of examples, is expensive and should therefore only be considered for the most promising options. As the whole approach is project-specific, its results can not be generalized. However, if different projects can reasonable argued as being similar, the evaluation of one project can also be applied to the other.

The method in its current form also has a lot of potential for refinement. A stronger formalization would allow for a better comparison of results and help to minimize unknown and unwanted influences. This would also better enable a generalization of the results. Once a large enough set of project-based criteria is established and scored for enough languages, this data can be used to reduce the workload for each new evaluation. Similarly, a classification of the implemented and compared examples from prior evaluations would allow to judge a languages suitability for a problem class without the need to implement new examples.

Can MicroPython be used on CubeSats?
------------------------------------

MicroPython enables the use of Python in constrained systems and can thereby potentially bring the ease of use of this language to space computing. The example implementations showed that MicroPython can meet the needs of a software project for a CubeSat. The possibility to write libraries for MicroPython in C, and the facilities to interface with C data structures allow to integrate both languages in a common system, enabling the developer to facilitate each languages strengths and compensate their respective weaknesses. However, this interoperability still has some problems, not in function, but in usability: the lack of documentation of the internal C API aggravates the development of custom modules. Furthermore, the need for two separate definitions of data structures to be shared across the language's poses a possible error source. Both issues can and should be addressed in further work.

What are the benefits and drawbacks of using MicroPython on CubeSats?
---------------------------------------------------------------------

The benefits of using Python in space are tied to its focus on readability, which can help avoiding programming errors by increasing the code quality. The faster development speed the language enables can also help to more effectively use development resources. Especially in early stages, when systems are prototyped, this speed can help to create proof-of-concepts earlier and free time for additional design iterations. It would also allow more members of the development team to participate in software development. As an example, at the moment the control engineer would develop the control algorithms using tools tailored for engineers, like Matlab and Labview. Later, a software developer re-implements these algorithms in a language that can run on the target hardware, typically C/C++. Using MicroPython would allow the control engineer to directly work on the target hardware in a language that is as usable as the prior tools. The software developer then could focus on ensuring a stable framework, improving the code quality and rewrite only the performance critical parts in a lower-level language.

The main drawbacks of using MicroPython are execution speed and availability. Both can be overcome, but require writing C code. By interfacing C code with MicroPython, performance critical parts of the system can retain the speed of C, while gaining the better usability of Python. In the scope of the prior example, this would mean that the software developer provides a fast C library that the control engineer can use from MicroPython. In the same way, the software developer would have to make sure that the used hardware is supported by MicroPython. If unsupported hardware is used, the developer would have to implement it. But also for already supported hardware, maintenance work can be necessary. Using Open Source software, like the MicroPython implementation, also requires a commitment to invest time into maintaining and expanding it.

Outlook
-------

This evaluation shows that usage of MicroPython for space projects is both beneficial and possible. In order to actually make it happen, further steps are needed. The key is to find paths to build the needed familiarity with MicroPython and further progress the project without risking a mission.

One possible area for that is the development of Ground Support Equipment (GSE) and testing tools to start building up know-how immediately.

The language can also be used as a rapid prototyping tool during the proof of concept phase. 

At last, a test on a CubeSat in orbit, where MicroPython would not act as mission critical infrastructure but as a software scientific payload, can finally prove the concept. In the MOVE-II project, this would be possible via a software update that installs MicroPython on the CubeSat and runs a set of tests. A possible chance to do so arises when the satellite is operational after fulfilling its primary mission.

\\ \\

Going beyond MicroPython, this evaluation hopes to enable bringing the language diversity that we enjoy in other programming domains to the world of space computing, while at the same time providing rationales to act against the rank growth this diversity may spur. Creating proper systems requires proper tools and a transparent way to chose those.

How can the fitness of a programming language and its implementation for space application be evaluated?
------------------------------------------------------

The method I propose in this thesis is a practical one:

#. Analyze the language according to the classic language evaluation criteria.
#. With your team, find a project that allows for experimentation. Define project-based language evaluation criteria and score the different languages you are interested in.
#. Implement the project (or parts of it) in the language you want to evaluate and a baseline language to compare against. When possibly use already implemented examples.

To evaluate the space readiness the project example has to come from a space application.

An additional, preceding, step is to investigate the language implementations determinism. It has to be possible to write deterministic programs in a language to be useful for space application.

This outcome is rather different from what I expected it to be. Space seemingly has a unique set of requirements on the systems designed to operate there, but for software they end up to be very much the same as on earth: run reliable, be easy to write and cheap to maintain. Many of the harsh environment influences on space system are not addressable in language. A programming language can not compensate for radiation events like bitflips or latch-ups. These things can be addressed by radiation proof hardware, lockstep dual-cores and software like fault tolerant file-systems. The language this software is written does not matter to the functionality.
Other requirements, like the memory, storage and performance restrictions however do limit the use of language to those ones that allow for small size and efficiency. But these traits are traits of the implementation, not necessarily the language.

Can MicroPython be used on CubeSats?
------------------------------------

MicroPython enables the use of Python in constrained systems and thereby can potentially bring the ease of use of this language to space computing. The example implementations showed that MicroPython can meet the needs of a software project for a CubeSat. The possibility to write libraries for MicroPython in C, and the facilities to interface with C data structures allow to integrate both languages in a common system, enabling the developer to facilitate each languages strengths and compensate their respective weaknesses. However, this interoperability still has some problems, not in function, but in usability: the lack of documentation of the internal C API aggravates the development of custom modules. Furthermore, the need for two separate definitions of data structures to be shared across the languages poses a possible error source.

What are the benefits and drawbacks of using MicroPython on CubeSats?
-------------------------------------------------------------

The benefits of using Python in space are tied to its focus on readability, which can help avoiding programming errors by increasing the code quality. The faster development speed the language enables can also help to more effectively use development resources. Especially in early stages, when systems are prototyped, this speed can help to create proof-of-concepts earlier and free time for additional design iterations.


This evaluations shows that usage of MicroPython for space projects is both beneficial and possible. In order to actually make it happen, further steps are needed by finding paths to build the needed familiarity with MicroPython and further progress the project without risking a mission. The first step is acknowledging that using MicroPython needs a commitment to work on the MicroPython project itself. After that, the development of Ground Support Equipment (GSE) and testing tools are an effective way to start building up know-how immediately. The language can also be used as a rapid prototyping tool during the proof of concept phase. Lastly, a test on a CubeSat in orbit where MicroPython would not act as mission critical infrastructure but act as a software scientific payload can quickly prove the concept.


Going beyond MicroPython, this evaluation hopes to enable bringing the language diversity that we enjoy in other programming domains to the world of space computing, while at the same time providing rationales to act against the rank growth this diversity may spur. Creating proper systems requires proper tools and a transparent way to chose those.

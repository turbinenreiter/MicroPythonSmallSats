MicroPython enables the use of Python in constrained systems and thereby
can potentially bring the ease of use of this language to space
computing. The benefits of using Python in space are tied to its focus
on readability, which can help avoiding programming errors by increasing
the code quality. The faster development speed the language enables can
also help to more effectively use development resources. Especially in
early stages, when systems are prototyped, this speed can help to create
proof-of-concepts earlier and free time for additional design
iterations.

The example implementations showed that MicroPython can meet the needs
of software project for a CubeSat. The possibility to write libraries
for MicroPython in C, and the facilities to interface with C data
structures allow to integrate both languages in a common system,
enabling the developer to facilitate each languages strengths and
compensate their respective weaknesses. However, this interoperability
still has some problems, not in function, but in usability: the lack of
documentation of the internal C API aggravates the development of custom
modules. Furthermore, the need for two separate definitions of data
structures to be shared across the languages poses a possible error
source.

This evaluations shows that usage of MicroPython for space projects is
both beneficial and possible. In order to actually make it happen,
further steps are needed by finding paths to build the needed
familiarity with MicroPython and further progress the project without
risking a mission. The first step is acknowledging that using
MicroPython needs a commitment to work on the MicroPython project
itself. After that, the development of Ground Support Equipment (GSE)
and testing tools are an effective way to start building up know-how
immediately. The language can also be used as a rapid prototyping tool
during the proof of concept phase. Lastly, a test on a CubeSat in orbit
where MicroPython would not act as mission critical infrastructure but
act as a software scientific payload can quickly prove the concept.

Going beyond MicroPython, this evaluation hopes to enable bringing the
language diversity that we enjoy in other programming domains to the
world of space computing, while at the same time providing rationales to
act against the rank growth this diversity may spur. Creating proper
systems requires proper tools and a transparent way to chose those.

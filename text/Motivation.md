Programming languages are tools to solve problems. Different problems
require different tools and the large number of existing, and also used,
languages provide ample resource to find one that fits the task at hand.

However, often the choice of language is severely constricted and the
choice is not made by project based criteria, but organizational ones.
The chosen languages are the ones that “have always been used”, that
“everyone else uses”, that are already “available for the development
system” or that are required in order to “satisfy contractual
obligations” [@howatt].

The special requirements for space systems, as well as the conservative
approach that is common in the industry, result in a very small set of
languages being actively used in this domain. For expensive and critical
projects, developers default to proven languages, leaving little room
for experimentation and thereby progress is slow. This work tries to
broaden the scope of suitable languages by evaluating the use of
MicroPython in a CubeSat project. CubeSats are small satellites with
standardized dimensions that can be launched as secondary payloads on
bigger missions, thus providing a low cost option of getting a satellite
in orbit. The low cost make them an ideal platform for pushing new
technologies in space.

First steps towards the use of MicroPython in space have already been
undertaken by an ESA project, motivated by a desire to write the
high-level application software in a language more suited to the
application layer, meaning a high-level language like Python. Compared
to C, Python enables higher productivity, more expressiveness,
higher-level language constructs and inherent language safety [@ESAupy].

Python is a language explicitly designed to aid readability. It has the
potential to address the rising complexity of space software system
simply by being easy to use. With the novel MicroPython implementation,
Python can be used on constrained systems, like those common in space
computing. These potential benefits and possibilities call for a
detailed evaluation designed to find strengths and weaknesses and to
establish use cases where space system developers can profit from using
MicroPython.

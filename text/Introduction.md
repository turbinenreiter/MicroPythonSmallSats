For decades, satellite design philosophy was dominated by highly
reliable components and conservative designs to achieve long lifetimes
in the harsh space environment. Since the dawn of the space age,
autonomy and control of the spacecraft made software one of the critical
aspects of success or failure. Multi-million dollar losses like Mars
Climate Orbiter [@polar], Ariane 5 flight 501 [@lions] and Mars Polar
Lander [@euler] can be traced back directly to software flaws. As the
scope of space systems, similar to terrestrial ones, broadens, the
complexity of the on-board software historically increased over the
years. An exponential growth rate of a factor of 10 approximately every
10 years was observed for software code in unmanned NASA spacecraft over
the last 40 years [@Dvorak]. As most large scale space programs are
risk-averse, choice of the programming language and other formal methods
during software development within the programs are heavy influenced by
heritage and other organizational criteria. CubeSats attempted to choose
a different philosophy, utilizing suitable state-of the art,
commercial-off-the shelf products. Novel computer architectures as well
as programming and scripting languages can be researched with less
resources and risk than in traditional space programs. Within the
MOVE-II satellite project [@Langer] of the Technical University of
Munich, several novel computing concepts are investigated. Amongst
others, this includes a fault-tolerant, radiation-robust filesystem
[@filesystem], autonomous Chip Level debugging [@debugging], dependable
data storage on miniaturized satellites [@datastorage] and a novel
communication protocol for miniaturized satellites [@appel]. This thesis
will investigate the ongoing research on using MicroPython [@upy] as
application layer programming language on CubeSats. First, the
motivation for the research is given in chapter 2. Chapter 3 deals with
the background of Python [@py], programming language evaluation and our
project based evaluation approach. In Chapter 4, the methods used for
evaluation are introduced. Results and first conclusions are later given
in Chapter 5. Finally, in Chapter 6, we conclude with the implications
of this work and give an outlook.

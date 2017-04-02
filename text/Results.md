Programming Language Evaluation
-------------------------------

<#include "Results_Language_Eval.md">

Project-Based Programming Language Evaluation
---------------------------------------------

<#include "Results_Project_Eval.md">

Toolchain Analysis \\label{sec:tools}
------------------

<#include "Results_Toolchain.md">

Example Implementations \\label{sec:ex}
-----------------------

The example implementations were developed using a Raspberry Pi acting as CDH and a Pyboard acting as the \\gls{ADCS} subsystem. Figure \\ref{sys}  shows a simplified overview of the system. The UNIX part of the software developed on the Raspberry Pi also works on the actual \\gls{CDH} hardware, the microcontroller counterpart on the Pyboard, however, does not run on the real \\gls{ADCS} boards. The \\gls{ADCS} subsystem uses ATXMEGA microcontrollers with an 8-bit architecture which is not suitable to run MicroPython.

![Schematic overview of the system. A Raspberry Pi running Linux and the UNIX port of MicroPython is connected to a Pyboard via SPI [@pi][@tux][@upyl].\\label{sys}](resources/figs/sys.png){ width=75% }

As the \\gls{ADCS} subsystem daemon uses D-Bus and \\gls{SPI} for communication and those libraries are not available for the targeted platform, the first step is to implement those.

### D-bus Library

<#include "Results_D-bus_Library.md">

### \\gls{SPI} Library {#SPI-library}

<#include "Results_SPI_Library.md">

### ADCS Daemon

<#include "Results_adcsd.md">

### BMX055 Sensor Driver

<#include "Results_BMX_Driver.md">

### Sensor Fusion

<#include "Results_Sensor_Fusion.md">

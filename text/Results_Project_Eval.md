The first step in the project-based language evaluation is the definition of the criteria. The criteria for the ADCS daemon are listed below, including an explanation and motivation for their inclusion.

#. The language enables memory safety.

    Memory errors can lead to system crashes, not just of the program itself but also of other programs running in parallel.

#. The language enables creation of programs with a small storage footprint.

    The hardware used on the CubeSat has limited storage space. The radiation environment in orbit negatively affects the storage and puts additional requirements on it.

#. The language enables creation of programs with a small memory footprint.

    The hardware used on the CubeSat has limited memory. The memory is also affected by radiation.

#. The language enables creation of efficient programs.

    The CubeSat has limited processing power, both as a result of limited battery power as well as thermal constraints. The lack of cooling thermally limits the processor speed.

#. The language enables creation of programs that can be updated using small incremental updates.

    The bandwidth to transfer data to the satellite is limited. Smaller updates mean shorter transmission times, decreasing the chance of failure as well as the power consumption. Given that transmission windows are short and limited, failed data uploads can lead to delays in operation.

#. An implementation of the language for the platform in use exists or can be created.

    The processors and microcontrollers for the mission are already chosen and can not be changed. Also, the choice is restricted by other factors, like space radiation hardness, power consumption and needed special features.

#. A library to use dbus on the platform in use exists or can be created.

    The system relies on Dbus for inter-process communication. The daemon has to provide methods via Dbus to control the ADCS hardware.

#. A library to use SPI on the platform in use exists or can be created.

    The communication between the CDH and the subsystem hardware happens via SPI. It is used to send commands to the ADCS hardware and receive data from it.

#. The language enables quick and easy file system access to read and write files.

    The daemon is responsible to log sensor data to a file. The data also has to be read back periodically to perform health checks by analyzing it. The daemon also has to read configuration parameters from files and update them.

#. The language provides quick and easy means to parse data.

    The program has to log sensor data to files as well as read the data back from the file to analyze it.

#. The language provides quick and easy means to handle strings.

    The program has to handle parameter updates that come in the form of strings. One example are two-line-elements (TLE) which contain orbit information.

#. The language provides quick and easy means to handle C-structs.

    The program has to read data and send commands to the subsystems by exchanging data in the form of C-structs via SPI.

According to these criteria, MicroPython, Python, C and C++ were compared and the results are shown in Table \\ref{criteria}. While Python shows its strengths in usability, it falls short in efficiency, where C shines. MicroPython may fix those shortcomings, but for a clear statement there is not enough information yet, which is why the comparison of example implementations are needed. MicroPython also comes with its own caveats in the form of missing libraries for D-bus and SPI on the Linux platform. Implementation of the missing parts is possible and relatively straightforward, but may have to be done in C. C++ addresses many of the shortcomings of C and is the clear leader in this comparison.

Table: Project-based Evaluation Criteria \\label{criteria}

------------------------------------------------------------------------------------------------------------------------------------
Criterion                                                                             Importance   MicroPython   Python    C    C++
------------------------------------------------------------------------------------ ------------ ------------- -------- ----- -----
The language enables memory safety.                                                       ++           ++          ++     – –    •  

The language enables creation of programs maintainable by changing developers.            ++           ++          ++      –     •  


The language enables splitting tasks between multiple programmers.                        ++           ++          ++      –     +  

The language enables creation of programs with a small storage footprint.                 +             +         – –     ++    ++  

The language enables creation of programs with a small memory footprint.                  +             +         – –     ++    ++  

The language enables creation of efficient programs.                                      +             +          •      ++    ++  

The language enables creation of programs that can be updated using small diffs.          ++            +          +       +     +  

An implementation of the language for the platform in use exists or can be created.       ++           ++          ++     ++    ++  

A library to use dbus on the platform in use exists or can be created.                    ++            •          ++     ++    ++  

A library to use SPI on the platform in use exists or can be created.                     ++            •          ++     ++    ++  

The language enables quick and easy file system access to read and write files.           +            ++          ++      +     +  

The language provides quick and easy means to parse data.                                 +            ++          ++      •     •  

The language provides quick and easy means to handle strings.                             +            ++          ++      •     •  

The language provides quick and easy means to handle C-structs.                           +            ++          ++     ++    ++  
------------------------------------------------------------------------------------------------------------------------------------


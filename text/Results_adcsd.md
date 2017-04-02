Using the MicroPython D-Bus and \\gls{SPI} libraries, a re-implementation of the \\gls{ADCS} subsystem daemon is possible.
Figure \\ref{fakesat} shows the development hardware used to test the C version of the daemon. Here, the gls\\{CDH} is emulated by a Beaglebone Black and the real \\gls{ADCS} main and side panels are used. The choice to work on different hardware for this thesis was taken to not interfere with the development process of the flight software. Given the strict timeframe for development of MOVE-II, I could not block the hardware by running tests not directly related to the actual project.

![The development hardware for the C version of the daemon.\\label{fakesat}](resources/figs/fakesat.jpeg){ width=75% }

The resulting software however, both the C any Python versions, are able to run on the Raspberry Pi, Beaglebone Black and original \\gls{CDH} hardware with no differences.

Because the original C version of this daemon is currently under heavy development and unfinished, a stable subset of its functionality was extracted to define a target for the re-implementation. This functionality includes:

* Setting the operational mode for \\gls{ADCS} hardware via D-Bus.
* Getting the current operational mode.
* Updating the clock of the \\gls{ADCS} main panel microcontroller from the \\gls{CDH} system time.
* Update different parameters used in the \\gls{ADCS} firmware, like controller gains or sensor calibration values.
* Get all data from the \\gls{ADCS} system.
* Check whether the daemon is available.
* Check whether the \\gls{ADCS} hardware is available.
* Log the data gathered by the \\gls{ADCS} system to the filesystem and read back logged data.
* Send a signal to the other daemons when the target of the set \\gls{ADCS} mode is reached, for example when detumbling was successful.

In a first step, the C data structures used in the original daemon are recreated in Python. There are two structures:

-   `control` is used by the daemon to send data to the subsystem which controls its functions. For example, the `mode` byte controls the operating mode of the subsystem.

-   `data` is populated with sensor data and state information from
    the subsystem.

The structure definitions can not be shared across the languages, which means that two versions of the definition have to be maintained. Any differences in the definitions lead to broken data, making this a serious source of error for all systems where MicroPython has to communicate with C via such data structures. This problem can be addressed in two ways: either by creating a tool that can translate the definitions between the languages or a tool that can automatically test the two structures against each other.

In the next step, the D-Bus interface is defined by creating the function bodies and registering them to the bus. Then, the actual functionality can be implemented. For this, the SPI library is used to transfer the data structures between the CDH and the ADCS subsystem.

In its current form the C implementation of the daemon results in a binary with a size of about 100 kB. The MicroPython implementation depends on the MicroPython interpreter, including the D-bus and SPI library, with a size of about 350 kB in total. The Python code itself is approximately 3 kB in size.

Table \\ref{tab:scd} shows size and complexity measures of the two examples.

Table: Size and complexity comparison of the \\gls{ADCS} Daemon \\label{tab:scd}

Language    Filename          LOC    Number of Tokens       CC
----------  --------------  -----  ------------------  -------
Python      adcsdaemon.py     103                 712  2
C++         adcsdaemon.cpp    216                1406  3.2

Comparing the length of the implementations, the C version is about about twice as long as the Python version. The Python version provides the same functionality as the original while being shorter, requiring less boilerplate code and being more readable. The \\gls{CC} is also reduced in the Python version. This reduction can mostly be attributed to the simplified and reduced error handling the language enables, as well as the higher abstraction level of the MicroPython D-Bus library when compared to the sd-bus library used in C.

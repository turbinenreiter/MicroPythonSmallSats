Sensor fusion allows us to calculate attitude from the different measurements of an IMU. In this example, I will use the Madgwick attitude and heading reference system (AHRS) algorithm [@sensorfusion]. It is an Open Source sensor fusion algorithm developed by Sebastian Madgwick, with source code provided in C. Peter Hinch created an implementation of the algorithm in Python aimed to be used on microcontrollers running MicroPython [@pyfusion]. This gives us two functionally identical implementations in two languages to compare.

I chose to use this algorithm rather than the one being developed in the scope of the MOVE-II project because of the development time frame. Our own algorithm is currently still being worked on. Re-implementing such a moving target in a different language is challenging, as the work on the ADCS daemon proved. On the daemon it worked because I am one of the main authors of the original implementation, meaning that I fully understand the project. The same is not the case for the attitude determination algorithms, which is why I chose to use already available algorithms instead.

The biggest caveat of this is that the Madgwick algorithm is not space ready: it relies on measuring the earth's gravitational field with the accelerometer, which is not an option in the 0-g environment in space. Nevertheless, the algorithms are similar in what they demand of the platform they run on: perform fast floating point calculation including trigonometry.

In both the C and Python version, there is a single function, called ```update```. It takes nine float values as input - acceleration, turn rate and magnetic field and all three spacial dimensions, and returns four values representing the attitude as quaternion.

~~~{.python}
import fusion

attitude = fusion.update(accel_x, accel_y, accel_z,
                         gyro_x, gyro_y, gyro_z,
                         mag_x, mag_y, mag_z,)
~~~

Table \\ref{tab:cmc} compares the code metrics of the two implementations.

Table: Code metric comparison \\label{tab:cmc}

Language   LOC   Average LOC per function   CCN   Avg.token
--------- ----- -------------------------- ----- -----------
Python     134      43.3                    4.3      569.0
C          130      62.0                    5.5      935.0

Interestingly, in this case the Python implementation is longer than the C implementation. Because the algorithm was directly translated from C to Python, these functions are almost the same length. The Python version embeds the function within a class, adding a few extra lines for the class definition. A part of this class definition is the ```__init__``` function, which does not exist in the C version. This results in the Python version having 3 functions, where the C version only has 2. The average LOC and token number is thereby heavily skewed, especially given that the ```__init__``` function is very short. Removing it drops the average LOC of the Python version to the same 62 lines that the C version has.
This shows that directly translating C to Python results in code that is equally readable - or unreadable. The resulting Python source is not idiomatic Python and little of the languages benefits come into play.
Both versions calculate quaternions, however, neither uses a quaternion data type. There is also no vector or matrix data type used, instead all the vector math is unrolled. This approach is terrible for readability but is an optimization for speed. Attitude determination algorithms need to run fast to enable dynamic control of vehicles.
The originals low readability is result of this seed optimization, the Python version does not improve on it.

Given these circumstances, for this example, the readability comparison is less interesting than a comparison of the implementations' speed, as shown in Table \\ref{tab:speedc}.

Table: Speed comparison \\label{tab:speedc}

Language               Platform      runs  total $s$    average $ms$
---------------------  --------- -------- ----------- --------------
C                      i5-5200U  100000   0.023       0.00023
MicroPython C-module   i5-5200U  100000   0.064       0.00064
MicroPython            i5-5200U  100000   3.130       0.03130
MicroPython            STM32F4   1000     1.679       1679
MicroPython native     STM32F4   1000     1.164       1164

The implementations were tested on an Intel i5 processor and the baseline is set by the C implementation, with an average time for the function to finish of $23~ns$. The MicroPython implementation takes about 135 times longer, which is a massive slowdown. Since MicroPython allows creation of modules in C, this is also compared. The C implementation is made available to MicroPython as a module by adding some simple wrapping and interface functions. This adds a total of 23 lines of code, 14 of which are translations from MicroPython objects to C types and from C types to MicroPython objects.
The C-module solution still creates a slowdown by a factor of almost 3, but allows to come close to the speed of C while retaining the ease of use of Python.

A different path for speed optimization are MicroPython's ```native``` and ```viper``` code emitters. They can be used by applying function decorators to the function that needs optimizing. The ```native``` emitter works with arbitrary Python code, except generators, and provides a speed up by compiling the function to native assembly code, on the cost of an increased compiled code size. The ```viper``` emitter further applies optimization to the code, but does not work on arbitrary Python code and requires type hints. These emitters are not available on all ports of MicroPython, which is why the ```native``` emitter was tested and compared on the STM32F405 microcontroller platform. The ```viper``` emitter was not tested at all, because it does not work without rewriting the function.
The speed-up gained by using the ```native``` emitter was about $30~\\%$. This optimization can be applied without any changes to the function, so there is no additionally development work necessary. Further optimization can not be achieved without rewriting code - either for the ```viper``` emitter, which requires adding type hints and removing unsupported language constructs, or by creating C modules.

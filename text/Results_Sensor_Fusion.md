Sensor fusion allows us to calculate attitude from the different measurements of an IMU. In this example, I will use the Madgwick attitude and heading reference system (AHRS) algorithm [@sensorfusion]. It is an Open Source sensor fusion algorithm developed by Sebastian Madgwick, with source code provided in C. Peter Hinch created an implementation of the algorithm in Python aimed to be used on microcontrollers running MicroPython [@pyfusion]. This gives us two functionally identical implementations in two languages to compare.

I chose to use this algorithm rather than the one being developed in the scope of the MOVE-II project because of the development time frame. Our own algorithm is currently still being worked on. Re-implementing such a moving target in a different language is challenging, as the work on the ADCS daemon proved. On the daemon it worked because I am one of the main authors of the original implementation, meaning that I fully understand the project. The same is not the case for the attitude determination algorithms, which is why I chose to use already available algorithms instead.

The biggest caveat of this is that the Madgwick algorithm is not space ready: it relies on measuring the earth's gravitational field with the accelerometer, which is not an option in the 0-g environment in space. Nevertheless, the algorithms are similar in what they demand of the platform they run on: perform fast floating point calculation including trigonometry.

Language   LOC   Average LOC per function   CCN   Avg.token
--------- ----- -------------------------- ----- -----------
Python     134      43.3                    4.3      569.0
C          130      62.0                    5.5      935.0

Interestingly, int this case the Python implementation is longer than the C implementation. Because the algorithm was directly translated from C to Python, these functions are almost the same length. The Python version embeds the function within a class, adding a few extra lines for the class definition. A part of this class definition is the ```__init__``` function, which does not exist in the C version. This results in the Python version having 3 functions, where the C version only has 2. The average LOC and token is thereby heavily skewed, especially given that the ```__init__``` function is very short. Removing it drops the average LOC of the Python version to the same 62 lines that the C version has.

Both versions calculate quaternions, however, neither uses a quaternion data type. There is also no vector or matrix data type used, instead all the vector math is unrolled. This approach is terrible for readability but is an optimization for speed. Attitude determination algorithms need to run fast to enable dynamic control of vehicles.

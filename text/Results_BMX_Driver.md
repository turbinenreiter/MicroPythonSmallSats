The Bosch BMX055 is an \\gls{IMU} that combines an accelerometer, gyroscope and magnetometer on a single chip. It is used by the ADCS to provide the sensing capabilities needed to determine the satellites attitude. \\glspl{IMU} have historically been expensive, high-precision sensors used in aircraft for navigation. They have also been of special interest for military purposes, like missile control, because they allow for dead reckoning - a navigation method independent of external dependencies. On the heels of the smartphone revolution however, these sensor became ubiquitous in consumer electronics where they are used to aid navigation apps, as input for games and in countless other creative ways. This created a huge market for cheap \\glspl{IMU} which in turn led to this type of sensor being commonly available. Today, those sensors can be bought for prices of €5 to €10 in quantities of one, making them available even for hobbyists.

To use the BMX055 sensor a device driver is needed. A device driver exposes the sensor's functionality to the programmer by providing a software library. The driver implements the communication between the microcontroller and the sensor. The most commonly used interfaces for communication are \\gls{I2C} and \\gls{SPI}. Many sensors, including the BMX055 support both interfaces. 

\\gls{I2C} is an addressed bus interface. It needs only two wires, a clock and a data line, and allows to collect a large number of sensors on the same interface. An address is used to specify which sensor is currently being communicated with.

SPI also is a bus interface, allowing for multiple sensors on the same bus, but uses an extra chip select line instead of addresses. It also uses two data line, instead of one, allowing it to send and receive at the same time.

Due to the smaller number of needed wires, \\gls{I2C} allows for simpler circuit design, however, SPI allows for faster bi-directional transfers and avoids possible collisions in the address space. For the ADCS hardware the SPI interface was chosen, motivated by bad experiences with \\gls{I2C} in space by other CubeSat teams.

In use, the two interfaces are very similar: in both cases a byte is send from the microcontroller to the sensor. This byte is the address of a register on the sensor. The sensor than responds with a byte that is the content of the register of the address it received. This allows to abstract the communication, making it easy to provide a driver that works with both interfaces.

The registers that can be read contain the measured sensor data. For example, the gyroscope can measure in three axis with 12 bit precision. As each register can only hold eight bits, the data is split between two registers - one containing the lower eight bits, the other one the remaining 4. The driver reads both, merges them to the 12 bit value and calculates the actual physical value in the desired unit.

In addition to registers that can be read there are also registers that can be written to, allowing to control the function of the sensor, for example, by setting different sensing ranges or frequencies for the internal low pass filter.

Using software metrics, shown in \\ref{tab:gcmc}, the implementation of the driver for the BMX055 gyroscope can be compared between the C++ and Python versions. The compared versions both implemented the following functionality:

* Wake up the sensor from sleep mode.
* Perform a self test of the sensor.
* Set and read the measurement range in $deg/s$.
* Configure the sensors internal data filter with a bandwidth in $Hz$ and read the current configuration.
* Return the measured x, y and z values.

Table: Size and Complexity Comparison of the Gyroscope Driver \\label{tab:gcmc}

Language    Filename          LOC    Number of Tokens       CC
----------  --------------  -----  ------------------  -------
Python      gyroscope.py       50                 516  1.5
C++         gyroscope.cpp      73                 450  2.5

The Python version of the code is shorter and less complex, but the difference is much smaller than it was for the \\gls{ADCS} daemon. The languages expressiveness and the quality of the ```machine``` module allow writing simple and high level code, even when dealing with hardware at the register level. However, the C version also uses a well designed interface for the communication. In addition, the C driver can use header files to define the register names and values. These header files do not count towards the programs size in this comparison, because they are simple tables that have no negative impact on the usability. A long header file does not add to a programs complexity when it only defines names for register values, but rather improves readability. In MicroPython, this split is not done, as the Python style prefers having a single file for each specific thematic. This example also used the optional type hints, adding tokens that are usually omitted compared to C code.

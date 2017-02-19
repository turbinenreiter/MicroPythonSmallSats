The Bosch BMX055 is an Internal Measurement Unit (IMU) that combines an accelerometer, gyroscope and magnetometer on a single chip. It is used by the ADCS to provide the sensing capabilities needed to determine the satellites attitude. IMUs have historically been expensive, high-precision sensors used in aircraft for navigation. They have also been of special interest for military purposes, like missile control, because they allow for dead reckoning - a navigation method independent of external dependencies. On the heels of the Smartphone revolution however these sensor became ubiquitous in consumer electronics where they are used to aid navigation apps, as input for games and in countless other creative ways. This created a huge market for cheap IMUs which in turn lead to common availability of such sensors. Today, those sensors can be bought for prices of €5 to €10 in quantities of one, making them available even for hobbyists. These sensors also are one of the key technologies enabling the emergence of the consumer drone industry. Oddly enough, despite the commonplaceness of IMUs in today's age, their heritage from the military industry still shine through from time to time when international shipping is needed, as the USA still has export restrictions on the technology in place.

To use the BMX055 sensor a device driver is needed. A device driver exposes the sensors functionality to the programmer by providing a software library. This driver implements the communication between the microcontroller and the sensor. The most commonly used interfaces for communication are I2C (Inter-Inter Circuit) and SPI (Serial Peripheral Interface). Many sensors, including the BMX055 support both interfaces. I2C is an addressed bus interface. It needs only two wires, a clock and a data line, and allows to collect a large number of sensors on the same interface. An address is used to specify which sensor is currently communicated with.
SPI is also a bus interface, allowing for multiple sensors on the same bus, but uses an extra chip select line instead of addresses. It also uses two data line, instead of one, allowing it to send and receive at the same time.
Due to the smaller number of needed wires, I2C allows for simpler circuit design, however SPI allows for faster bi-directional transfers and avoids possible collisions in the address space. For the ADCS hardware the SPI interface was chosen motivated by bad experiences with I2C in space by other CubeSat teams.

The two interfaces are very similar in use: in both cases a byte is send from the microcontroller to the sensor. This byte is the address of a register on the sensor. The sensor than response with a byte that is the content of the register of the address it received. This allows to simply abstract the communication making it easy to provide a driver that works with both interfaces.

The registers that can be read contain the measured sensor data. For example, the gyroscope can measure in three axis with 12 bit precision. As each register can only hold eight bits, the data is split between two - one containing the lower eight bits, the other on the remaining 4. The driver reads both, merges them to the 12 bit value and calculates the actual physical value in the desired unit.

In addition to registers than be read there are also registers that can be written to, allowing to control the function of the sensor, for example setting different sensing ranges or frequencies for the internal low pass filter.

In the following section the implementation of the driver for the BMX055 gyroscope is compared between the C++ and Python version using software metrics.

Table: Software metric comparison of gyroscope driver in Python and C++

Language   LOC   Average LOC per function   CCN   Avg.token
--------- ----- -------------------------- ----- -----------
Python     68        5.5                    1.5       55.8
C++        276      13.7                    2.8       80.0



### \\gls{SPI} Library {#SPI-library}

MicroPython's hardware \\gls{API} is a module called ```machine``` which provides access to peripherals like \\gls{SPI}. Currently, the UNIX version of MicroPython lacks this machine module. On UNIX systems, hardware access via device drivers is abstracted by a device file, allowing to interface by simple input/output system calls. The hardware is controlled by reading and writing special content to special files.

Python-periphery is a pure Python library providing hardware access by using these device files and it can be used with MicroPython after slight modifications [@pp]. Because the \\gls{API} it provides is different from the native MicroPython hardware \\gls{API}, I changed it to mimic MicroPython's \\gls{API}, thereby creating a UNIX port of the machine module.

This unified MicroPython \\gls{API} allows for all code that is written using the ```machine``` module to be portable between the implementations running on microcontrollers and on the UNIX platform.

When the SPI communication is used between systems programmed in Python and C, the ```ctypes``` library can be used. This allows to create, read and use native C types in Python. To streamline working with ```ctypes``` to be sent via SPI, I developed a simple wrapper classed called ```mystruct```.

```mystruct``` provides a class called ```struct```. An object is instantiated with two arguments: a dictionary containing names and type information for the ```ctypes``` data structure and the length of the structure in bytes.

``` {.python}
control = struct({'new': ctypes.UINT8 | 0,
                  'mode': ctypes.UINT8 | 1,
                  'time': ctypes.UINT32 | 2,}, 38)
```

The data held by the ```control``` object can now be accessed in two different ways: as a structure or as the raw bytes. Accessing it as a struct allows to change and read the data in the corresponding data types.

``` {.python}
>>> control.struct.new = 1
>>> print(control.struct.new)
1
```

Accessing the raw bytes allows to easily send and receive data via SPI. The SPI Master as well as the SPI slave device both have a data structure for the SPI transfer. For example, the structure on the Master that controls the function of the Slave is called ```control```, the structure on the Slave that is used to transfer sensor data back to the Master is called ```data```.
On the Master, the ```control``` structure is updated with the information for the Slave, for example the ```mode``` is set to 1. Then, using the ```send_recv``` command, the bytes of the ```control``` structure are sent to the Slave, while the bytes of the ```data``` structure are returned back. Now both structures on both devices contain the same data. The Slave can use the ```mode``` information to switch its operation to the desired mode, and the Master can access the sensor data of the Slave.
Both structures have to have the same length in bytes. When the structures they contain do not have the same length, the length in bytes of the longer one is used for both structures. The unused bytes at the end of the shorter structure contain zeros and do not effect the system in any way.

``` {.python}
>>> control.struct.mode = 1
>>> data.bytes = spi.send_recv(control.bytes)
>>> print(data.struct.accel.x)
0.997
```

At the moment, the SPI library provides only the ```send_recv``` transfer method. MicroPython's ```machine``` module implements additional methods, like ```send``` and ```recv```. These can easily be implemented on top of the ```send_recv``` method, which represents the atomic functionality of the \\gls{SPI} hardware. For the \\gls{ADCS} daemon, only this atomic method is needed.

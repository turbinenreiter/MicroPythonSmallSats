* ```SPI```

The ```SPI``` module implements \\gls{SPI} for MicroPython on the UNIX platform.

* ```spi.SPI(device: str, baudrate: int)```

An ```spi.SPI``` object is created for the specified ```device``` with ```baudrate```.

* ```spi.send_recv(bytes: bytearray)```

The ```bytes``` are sent to the Slave at the objects \\gls{SPI} device. The function returns a ```bytearray``` containing the data sent back to the Master.

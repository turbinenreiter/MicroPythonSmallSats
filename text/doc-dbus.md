* __```dbus```__

```dbus``` is a C module for the UNIX-port of MicroPython that allows to communicate over the D-Bus.

* __```dbus.register(function: Callable, input_type: str, output_type: str)```__

```register``` registers the ```function``` with the ```input_type``` and ```output_type```.

Valid types are:

type    signature
------- ----------
bool    'b'
integer 'n'
float   'd'
string  's'
array   'a'

Arrays are written as i.e. 'ai' for an array of integers. Currently, arrays can only be used for the output.

* __```dbus.init(object_name: str, object_path: str)```__

```init``` initializes the object with the ```object_name``` and ```object_path``` on the D-Bus.

* __```dbus.process(timeout: int)```__

```process``` processes D-Bus requests for ```timeout``` seconds.

* __```dbus.signal(object_name: str, object_path: str, signal: str)```__

```signal``` sends the ```signal``` from the ```object_name``` at  ```object_path```. Currently signals can only be strings.

* __```dbus.deinit(object_name: str, object_path: str)```__

```deinit``` removes the ```object_name``` at ```object_path``` from the D-Bus.

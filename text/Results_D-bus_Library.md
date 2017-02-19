### D-bus Library

A minimal D-bus library for the UNIX port of MicroPython was implemented
in C, allowing MicroPython functions to be exposed as methods on the
user bus. The underlying C library is sd-bus [@sdbus], which is also
used in the C implementation of the daemon on the MOVE-II CubeSat. The
library can thus be shared and the added size is only the size of the
MicroPython bindings. When using sd-bus in C, to expose functionality on
the D-bus, it has to be wrapped in a function like shown in Listing
\\ref{lst:methodC}. The function logic can either be directly implemented
in this interface function, or the interface can be separated from the
logic by moving the logic into a external function that is only called
from the interface function. The interface function parses the input
data from the D-bus message and replies with with another message,
containing the data created by the function logic.

``` {.c}
static int foo(sd_bus_message *m, void *userdata, sd_bus_error *ret_error) {
    uint8_t input;
    uint8_t output;
    int r;

    /* Read the input parameters */
    r = sd_bus_message_read(m, "y", &input);
    if (r < 0) {
        fprintf(stderr, "Failed to parse parameters: %s\n", strerror(-r));
        return r;
    }

    /* function logic */
    output = input;

    /* Reply with the response */
    return sd_bus_reply_method_return(m, "y", output);
}
```

Using the MicroPython D-bus library, as shown in Listing
\\ref{lst:methodPy}, no boilerplate code is needed. Only the function
providing the functionality has to be defined. Type hints are used in
the example, but can be omitted.

``` {.python}
def spam(inp: int) -> int:
    output = inp
    return(output)
```

After having defined a function to be exposed as method, they have to be
registered to the bus. In C, this means including the method in a
`vtable` that is later passed to the object registered on the bus.
Listing \\ref{lst:regC} shows the vtable. The first argument to
`SD_BUS_METHOD` is the method name, followed by the type of the input
(“y” means byte in the D-bus convention), type of output, the function
pointer and the permission flag. The first and last entry of the table
are standardized and provided by the library.

``` {.c}
static const sd_bus_vtable daemon_vtable[] = {
    SD_BUS_VTABLE_START(0),
    SD_BUS_METHOD("foo", "y", "y", foo, SD_BUS_VTABLE_UNPRIVILEGED),
    SD_BUS_VTABLE_END
};
```

Listing \\ref{lst:regPy} shows how this is done in Python by passing the
function to the libraries `register` method. The two other arguments
again are input and output data type.

``` {.python}
dbus.register(foo, 'y', 'y')
```

In Python there is only one integer data type - `int` - as opposed to
the more fine grained options C provides. This means that internally the
MicroPython D-bus library handles all versions of integers with the
Python `int` type.

Finally, the daemon has to connect to the bus and listen for calls. The
snippet in Listing \\ref{lst:runC} has been shortened by removing the error
handling to make it easier to grasp. The user bus is opened, the object
added with the object name and object path and the `vtable` is passed.
The name is requested on the bus and then the daemon starts listening on
the bus in a loop.

``` {.c}
int main() {
    sd_bus_slot *slot = NULL;
    sd_bus *bus = NULL;
    int r;
    
    r = sd_bus_open_user(&bus);
    
    r = sd_bus_add_object_vtable(bus,
            &slot,
            "/space/test",
            "space.test",
            daemon_vtable,
            NULL);
            
    r = sd_bus_request_name(bus, ADCS_OBJECT_NAME, 0);
    
    for (;;) {
        r = sd_bus_process(bus, NULL);
        if (r > 0)
            continue;
        r = sd_bus_wait(bus, (uint64_t) -1);
    }
    sd_bus_slot_un\ref(slot);
    sd_bus_un\ref(bus);
    return r < 0 ? EXIT_FAILURE : EXIT_SUCCESS;
}
```

The Python equivalent is shown in Listing \\ref{lst:runPy}. The two
arguments are the object name and path.


``` {.python}
dbus.run('space.test', '/space/test')
```

The Python implementation is a total of six lines long, the C
implementation about 10 times that. However, this is in part caused by
the higher level of abstraction the MicroPython D-bus library offers.
This library is implemented in C and the source code looks very similar
to the code of the C program. For example, the `dbus.register` method
does nothing more than dynamically inject the function pointer in the
`vtable`. Similarly, `dbus.run` merely wraps what can be seen in the C
`main` function.

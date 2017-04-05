This section gives an overview of the parts needed to create C-modules for MicroPython.

__Needed headers__

* ```"py/mpconfig.h"```
* ```"py/obj.h"```
* ```"py/runtime.h"```

__Defining Functions__

Functions that are supposed to be exposed to MicroPython need to have the type ```STATIC mp_obj_t``` and return a variable of the type ```mp_obj_t```.

__Exposing Functions__

After the function was defined, a set of macros can be used to expose it, depending on the number of arguments it takes.

For functions with zero arguments:

~~~{.c}
STATIC MP_DEFINE_CONST_FUN_OBJ_0(<function-name>_obj, <function-name>);
~~~

For functions with one argument:

~~~{.c}
STATIC MP_DEFINE_CONST_FUN_OBJ_1(<function-name>_obj, <function-name>);
~~~

For functions with two arguments:

~~~{.c}
STATIC MP_DEFINE_CONST_FUN_OBJ_2(<function-name>_obj, <function-name>);
~~~

For functions with three arguments:

~~~{.c}
STATIC MP_DEFINE_CONST_FUN_OBJ_3(<function-name>_obj, <function-name>);
~~~

For functions with other numbers of arguments:

~~~{.c}
STATIC MP_DEFINE_CONST_FUN_OBJ_VAR_BETWEEN(<function-name>_obj, <min-no-of-args>, <max-no-of-args>, <function-name>);
~~~

For example:

~~~{.c}
STATIC mp_obj_t example(size_t n_args, const mp_obj_t *args) {
    (void)n_args;

    float arg0 = mp_obj_get_float(args[0]); // make C float out of mp_obj_t
    float arg1 = mp_obj_get_float(args[1]); // make C float out of mp_obj_t

    return mp_obj_new_float(arg0 + arg1); // create new MicroPython float from C float
}
STATIC MP_DEFINE_CONST_FUN_OBJ_VAR_BETWEEN(example_obj, 2, 2, example); // min-arg = max-arg = 2-> exactly two arguments (OBJ_2 should be used here, but using OBJ_VAR for demonstration)
~~~

__Creating the MicroPython bindings__

* ROM elements

A ```STATIC const mp_rom_map_elem_t``` holds the strings needed for the module: its name and the name of its functions. These strings are stored in the ROM.

For example:

~~~{.c}
STATIC const mp_rom_map_elem_t mp_module_<module-name>_globals_table[] = {
    { MP_ROM_QSTR(MP_QSTR___name__), MP_ROM_QSTR(MP_QSTR_<module-name>) },
    { MP_ROM_QSTR(MP_QSTR_<function-name>), (mp_obj_t)&mod_<function-name>_update_obj },
};
~~~

* Module dictionary

The ```MP_DEFINE_CONST_DICT``` creates a dictionary for the module:

~~~{.c}
STATIC MP_DEFINE_CONST_DICT(mp_module_<module-name>_globals, mp_module_dbus_globals_table);
~~~

* Module object

At last, a module object is defined:

~~~{.c}
const mp_obj_module_t mp_module_<module-name> = {
.base = { &mp_type_module },
.globals = (mp_obj_dict_t*)&mp_module_<module-name>_globals,
};
~~~

All of the above is written to a single C file which is best stored in the ```extmod``` folder with the name ```mod<module-name>.c```.

* Adding the module to the build

In the Makefile, the source file has to be added:

~~~
EXTMOD_SRC_C = $(addprefix extmod/,\
   mod<module-name>.c \
   )

OBJ += $(addprefix $(BUILD)/, $(EXTMOD_SRC_C:.c=.o))

SRC_QSTR += $(SRC_C) $(LIB_SRC_C) $(EXTMOD_SRC_C)
~~~

Finally, the module has to be added in the ```mpconfigport.h``` file:

~~~
#define MICROPY_PY_<MODULE-NAME> (1)

extern const struct _mp_obj_module_t mp_module_<module-name>;

#if MICROPY_PY_<MODULE-NAME>
#define MICROPY_PY_<MODULE-NAME>_DEF { MP_OBJ_NEW_QSTR(MP_QSTR_<module_name>), (mp_obj_t)&mp_module_<module_name> },
#else
#define MICROPY_PY_<MODULE-NAME>_DEF
#endif

#define MICROPY_PORT_BUILTIN_MODULES \
MICROPY_PY_<MODULE-NAME>_DEF
~~~

__Useful functions for interfacing C and MicroPython__

Calling a MicroPython function from C:

~~~{c.}
mp_call_function_<number-of-arguments>(<function-pointer>, <argument, ...>)
~~~

Creating C data types from MicroPython objects:

~~~{.c}
mp_obj_get_array(mp_obj_t obj_name, int array_length, <type> array)
mp_obj_get_int(mp_obj_t obj_name)
mp_obj_get_float(mp_obj_t obj_name)
mp_obj_str_get_qstr(mp_obj_t obj_name)
~~~

Creating MicroPython objects from C data types:

~~~{.c}
mp_obj_new_bool(bool bool_name)
mp_obj_new_int_from_ll(int64_t int_name)
mp_obj_new_float(float float_name)
mp_obj_new_str(char* string_name, mp_uint_t size)
mp_obj_new_list(int length, <type> array)
mp_obj_list_append(mp_obj_t list_name, mp_obj_t new_entry)
~~~

\\ \\

The functions described here are not all available functions. More can be found in ```py/obj.h```. A useful tool to learn how functions are used is ```grep```. It allows to search the codebase for occurrences of a certain string, for example a function name. From the examples found that way, it can be learned how to use them. Friendly people willing to help can be found at ```forums.micropython.org```, where there is also already an archive with many answers.

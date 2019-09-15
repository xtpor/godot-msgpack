
# godot-msgpack

A MessagePack serializer implemented in pure GDScript

- No dependency
- No native binding required

# Installation

Copy the `msgpack.gd` at the root of the repository into your godot project

# Usage

```gdscript
var Msgpack = preload("res://msgpack.gd")

func _myfunc():
    var data = {"type": "wizard", "attack": 10, "weapon": ["dagger", "staff"]}

    var res = Msgpack.encode(data)
    print(res.result) # A PoolByteArray of the data encoded MessagePack

    var res2 = Msgpack.decode(res.result)
    print(res2.result) # Get back the original data
```

## class `Msgpack`

### `static Dictionary encode(Variant value)`

Convert a value (number, string, array and dictionary) into their
counterparts in messagepack. Returns dictionary with three fields:
`result` which is the packed data (a PoolByteArray); `error` which is the
error code; and `error_string` which is a human readable error message

### `static Dictionary decode(PoolByteArray bytes)`

Convert a packed data (a PoolByteArray) back into a value, the reverse of the
encode function. The return value is similar to the one in the encode
method

# Limitation

- Only support null, boolean, integer, float, PoolByteArray, string, array and
  dictionary. No support for other data type like Vector2 and Vector3
- No support for the ext datatype in MessagePack
- Slow compare to the built-in binary serialization in godot

# Testcases

```
godot -s run_test.gd
```

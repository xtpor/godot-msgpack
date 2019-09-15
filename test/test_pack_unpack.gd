
var Util = load("res://test/utils.gd")

func run(module):
    var success_count = 0
    var testcases = pairs()
    print("[#] Testing packing and unpacking")

    # test encode
    print("* Testing packing")
    print()
    success_count = 0
    for case in testcases:
        var encoded_result = module.encode(case.value)
        var encoded = encoded_result.result
        if encoded in case.msgpack:
            success_count += 1
        else:
            print(" * Failed encode %s" % [case.name])
            print("Input:")
            print("  %s" % [case.value])
            print("Expect one of:")
            for expected in case.msgpack:
                print("  %s" % [Util.to_hex(expected)])
            print("Instead found:")
            print("  %s" % [Util.to_hex(encoded)])
            print("")
    print("%s testcases passed" % [success_count])
    print()

    print("* Testing unpacking")
    print()
    success_count = 0
    for case in testcases:
        for bytes in case.msgpack:
            var decoded_result = module.decode(bytes)
            var decoded = decoded_result.result
            if Util.equals(decoded, case.value):
                success_count += 1
            else:
                print(" * Failed decode %s" % [case.name])
                print("Input:")
                print("  %s" % [Util.to_hex(bytes)])
                print("Expect:")
                print("  %s" % [case.value])
                print("Instead found:")
                print("  %s" % [decoded])
                print()
    print("%s testcases passed" % [success_count])
    print()

func pairs():
    return [
        {
            name = "type nil",
            value = null,
            msgpack = [
                PoolByteArray([0xc0])
            ]
        },
        {
            name = "type bool true",
            value = true,
            msgpack = [
                PoolByteArray([0xc3])
            ]
        },
        {
            name = "type bool false",
            value = false,
            msgpack = [
                PoolByteArray([0xc2])
            ]
        },

        # Positive fixnum integer
        {
            name = "integer 0",
            value = 0,
            msgpack = [
                PoolByteArray([0x00]),
                PoolByteArray([0xcc, 0x00]),
                PoolByteArray([0xcd, 0x00, 0x00]),
                PoolByteArray([0xce, 0x00, 0x00, 0x00, 0x00]),
                PoolByteArray([0xcf, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00]),
                PoolByteArray([0xd0, 0x00]),
                PoolByteArray([0xd1, 0x00, 0x00]),
                PoolByteArray([0xd2, 0x00, 0x00, 0x00, 0x00]),
                PoolByteArray([0xd3, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00]),
            ]
        },
        {
            name = "integer 1",
            value = 1,
            msgpack = [
                PoolByteArray([0x01]),
                PoolByteArray([0xcc, 0x01]),
                PoolByteArray([0xcd, 0x00, 0x01]),
                PoolByteArray([0xce, 0x00, 0x00, 0x00, 0x01]),
                PoolByteArray([0xcf, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01]),
                PoolByteArray([0xd0, 0x01]),
                PoolByteArray([0xd1, 0x00, 0x01]),
                PoolByteArray([0xd2, 0x00, 0x00, 0x00, 0x01]),
                PoolByteArray([0xd3, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01]),
            ]
        },
        {
            name = "integer 126",
            value = 126,
            msgpack = [
                PoolByteArray([0x7e]),
                PoolByteArray([0xcc, 0x7e]),
                PoolByteArray([0xcd, 0x00, 0x7e]),
                PoolByteArray([0xce, 0x00, 0x00, 0x00, 0x7e]),
                PoolByteArray([0xcf, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x7e]),
                PoolByteArray([0xd0, 0x7e]),
                PoolByteArray([0xd1, 0x00, 0x7e]),
                PoolByteArray([0xd2, 0x00, 0x00, 0x00, 0x7e]),
                PoolByteArray([0xd3, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x7e]),
            ]
        },
        {
            name = "integer 127",
            value = 127,
            msgpack = [
                PoolByteArray([0x7f]),
                PoolByteArray([0xcc, 0x7f]),
                PoolByteArray([0xcd, 0x00, 0x7f]),
                PoolByteArray([0xce, 0x00, 0x00, 0x00, 0x7f]),
                PoolByteArray([0xcf, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x7f]),
                PoolByteArray([0xd0, 0x7f]),
                PoolByteArray([0xd1, 0x00, 0x7f]),
                PoolByteArray([0xd2, 0x00, 0x00, 0x00, 0x7f]),
                PoolByteArray([0xd3, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x7f]),
            ]
        },

        # Negative fixnum integer
        {
            name = "integer -1",
            value = -1,
            msgpack = [
                PoolByteArray([0xff]),
                PoolByteArray([0xd0, 0xff]),
                PoolByteArray([0xd1, 0xff, 0xff]),
                PoolByteArray([0xd2, 0xff, 0xff, 0xff, 0xff]),
                PoolByteArray([0xd3, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff]),
            ]
        },
        {
            name = "integer -2",
            value = -2,
            msgpack = [
                PoolByteArray([0xfe]),
                PoolByteArray([0xd0, 0xfe]),
                PoolByteArray([0xd1, 0xff, 0xfe]),
                PoolByteArray([0xd2, 0xff, 0xff, 0xff, 0xfe]),
                PoolByteArray([0xd3, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xfe]),
            ]
        },
        {
            name = "integer -31",
            value = -31,
            msgpack = [
                PoolByteArray([0xe1]),
                PoolByteArray([0xd0, 0xe1]),
                PoolByteArray([0xd1, 0xff, 0xe1]),
                PoolByteArray([0xd2, 0xff, 0xff, 0xff, 0xe1]),
                PoolByteArray([0xd3, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xe1]),
            ]
        },
        {
            name = "integer -32",
            value = -32,
            msgpack = [
                PoolByteArray([0xe0]),
                PoolByteArray([0xd0, 0xe0]),
                PoolByteArray([0xd1, 0xff, 0xe0]),
                PoolByteArray([0xd2, 0xff, 0xff, 0xff, 0xe0]),
                PoolByteArray([0xd3, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xe0]),
            ]
        },

        # uint8
        {
            name = "integer 255 (maximum of uint8)",
            value = 255,
            msgpack = [
                PoolByteArray([0xcc, 0xff]),
                PoolByteArray([0xcd, 0x00, 0xff]),
                PoolByteArray([0xce, 0x00, 0x00, 0x00, 0xff]),
                PoolByteArray([0xcf, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff]),
                PoolByteArray([0xd1, 0x00, 0xff]),
                PoolByteArray([0xd2, 0x00, 0x00, 0x00, 0xff]),
                PoolByteArray([0xd3, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff]),
            ]
        },

        # uint16
        {
            name = "integer 65535 (maximum of uint16)",
            value = 65535,
            msgpack = [
                PoolByteArray([0xcd, 0xff, 0xff]),
                PoolByteArray([0xce, 0x00, 0x00, 0xff, 0xff]),
                PoolByteArray([0xcf, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff, 0xff]),
                PoolByteArray([0xd2, 0x00, 0x00, 0xff, 0xff]),
                PoolByteArray([0xd3, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff, 0xff]),
            ]
        },

        # uint32
        {
            name = "integer 4,294,967,295 (maximum of uint32)",
            value = 4294967295,
            msgpack = [
                PoolByteArray([0xce, 0xff, 0xff, 0xff, 0xff]),
                PoolByteArray([0xcf, 0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0xff]),
                PoolByteArray([0xd3, 0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0xff]),
            ]
        },

        # int8
        {
            name = "integer -128 (minimum of int8)",
            value = -128,
            msgpack = [
                PoolByteArray([0xd0, 0x80]),
                PoolByteArray([0xd1, 0xff, 0x80]),
                PoolByteArray([0xd2, 0xff, 0xff, 0xff, 0x80]),
                PoolByteArray([0xd3, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x80]),
            ]
        },

        # int16
        {
            name = "integer -32768 (minimum of int16)",
            value = -32768,
            msgpack = [
                PoolByteArray([0xd1, 0x80, 0x00]),
                PoolByteArray([0xd2, 0xff, 0xff, 0x80, 0x00]),
                PoolByteArray([0xd3, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x80, 0x00]),
            ]
        },
        {
            name = "integer 32767 (maximum of int16)",
            value = 32767,
            msgpack = [
                PoolByteArray([0xcd, 0x7f, 0xff]),
                PoolByteArray([0xce, 0x00, 0x00, 0x7f, 0xff]),
                PoolByteArray([0xcf, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x7f, 0xff]),
                PoolByteArray([0xd1, 0x7f, 0xff]),
                PoolByteArray([0xd2, 0x00, 0x00, 0x7f, 0xff]),
                PoolByteArray([0xd3, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x7f, 0xff]),
            ]
        },

        # int32
        {
            name = "integer -2,147,483,648 (minimum of int32)",
            value = -2147483648,
            msgpack = [
                PoolByteArray([0xd2, 0x80, 0x00, 0x00, 0x00]),
                PoolByteArray([0xd3, 0xff, 0xff, 0xff, 0xff, 0x80, 0x00, 0x00, 0x00]),
            ]
        },
        {
            name = "integer 2,147,483,647 (maximum of int32)",
            value = 2147483647,
            msgpack = [
                PoolByteArray([0xce, 0x7f, 0xff, 0xff, 0xff]),
                PoolByteArray([0xcf, 0x00, 0x00, 0x00, 0x00, 0x7f, 0xff, 0xff, 0xff]),
                PoolByteArray([0xd2, 0x7f, 0xff, 0xff, 0xff]),
                PoolByteArray([0xd3, 0x00, 0x00, 0x00, 0x00, 0x7f, 0xff, 0xff, 0xff]),
            ]
        },

        # int64
        {
            name = "integer -9,223,372,036,854,775,808 (minimum of int64)",
            value = -9223372036854775808,
            msgpack = [
                PoolByteArray([0xd3, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00]),
            ]
        },
        {
            name = "integer 9,223,372,036,854,775,807 (maximum of int64)",
            value = 9223372036854775807,
            msgpack = [
                PoolByteArray([0xcf, 0x7f, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff]),
                PoolByteArray([0xd3, 0x7f, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff]),
            ]
        },

        # float
        {
            name = "float 123.4567",
            value = 123.4567,
            msgpack = [
                PoolByteArray([0xca, 0x42, 0xf6, 0xe9, 0xd5]),
                PoolByteArray([0xcb, 0x40, 0x5e, 0xdd, 0x2f, 0x1a, 0x9f, 0xbe, 0x77]),
            ]
        },

        # string
        {
            name = "empty string",
            value = "",
            msgpack = [
                PoolByteArray([0xa0]),
                PoolByteArray([0xd9, 0x00]),
                PoolByteArray([0xda, 0x00, 0x00]),
                PoolByteArray([0xdb, 0x00, 0x00, 0x00, 0x00]),
            ]
        },
        {
            name = "string 'hello world!'",
            value = "hello world!",
            msgpack = [
                PoolByteArray([0xac, 0x68, 0x65, 0x6c, 0x6c, 0x6f, 0x20, 0x77, 0x6f, 0x72, 0x6c, 0x64, 0x21]),
                PoolByteArray([0xd9, 0x0c, 0x68, 0x65, 0x6c, 0x6c, 0x6f, 0x20, 0x77, 0x6f, 0x72, 0x6c, 0x64, 0x21]),
                PoolByteArray([0xda, 0x00, 0x0c, 0x68, 0x65, 0x6c, 0x6c, 0x6f, 0x20, 0x77, 0x6f, 0x72, 0x6c, 0x64, 0x21]),
                PoolByteArray([0xdb, 0x00, 0x00, 0x00, 0x0c, 0x68, 0x65, 0x6c, 0x6c, 0x6f, 0x20, 0x77, 0x6f, 0x72, 0x6c, 0x64, 0x21]),
            ]
        },
        {
            name = "string 200 'a'",
            value = _string_repeat("a", 200),
            msgpack = [
                PoolByteArray([0xd9, 0xc8]) + _byte_repeat(0x61, 200),
                PoolByteArray([0xda, 0x00, 0xc8]) + _byte_repeat(0x61, 200),
                PoolByteArray([0xdb, 0x00, 0x00, 0x00, 0xc8]) + _byte_repeat(0x61, 200),
            ]
        },
        {
            name = "string 2000 'a'",
            value = _string_repeat("a", 2000),
            msgpack = [
                PoolByteArray([0xda, 0x07, 0xd0]) + _byte_repeat(0x61, 2000),
                PoolByteArray([0xdb, 0x00, 0x00, 0x07, 0xd0]) + _byte_repeat(0x61, 2000),
            ]
        },
        {
            name = "string 70000 'a'",
            value = _string_repeat("a", 70000),
            msgpack = [
                PoolByteArray([0xdb, 0x00, 0x01, 0x11, 0x70]) + _byte_repeat(0x61, 70000),
            ]
        },

        # binary
        {
            name = "empty binary",
            value = PoolByteArray([]),
            msgpack = [
                PoolByteArray([0xc4, 0x00]),
                PoolByteArray([0xc5, 0x00, 0x00]),
                PoolByteArray([0xc6, 0x00, 0x00, 0x00, 0x00]),
            ]
        },
        {
            name = "binary 01 02 03 04 05",
            value = PoolByteArray([1, 2, 3, 4, 5]),
            msgpack = [
                PoolByteArray([0xc4, 0x05, 0x01, 0x02, 0x03, 0x04, 0x05]),
                PoolByteArray([0xc5, 0x00, 0x05, 0x01, 0x02, 0x03, 0x04, 0x05]),
                PoolByteArray([0xc6, 0x00, 0x00, 0x00, 0x05, 0x01, 0x02, 0x03, 0x04, 0x05]),
            ]
        },
        {
            name = "200 repeating '0xab'",
            value = _byte_repeat(0xab, 200),
            msgpack = [
                PoolByteArray([0xc4, 0xc8]) + _byte_repeat(0xab, 200),
                PoolByteArray([0xc5, 0x00, 0xc8]) + _byte_repeat(0xab, 200),
                PoolByteArray([0xc6, 0x00, 0x00, 0x00, 0xc8]) + _byte_repeat(0xab, 200),
            ]
        },
        {
            name = "2500 repeating '0xab'",
            value = _byte_repeat(0xab, 2500),
            msgpack = [
                PoolByteArray([0xc5, 0x09, 0xc4]) + _byte_repeat(0xab, 2500),
                PoolByteArray([0xc6, 0x00, 0x00, 0x09, 0xc4]) + _byte_repeat(0xab, 2500),
            ]
        },
        {
            name = "72500 repeating '0xab'",
            value = _byte_repeat(0xab, 72500),
            msgpack = [
                PoolByteArray([0xc6, 0x00, 0x01, 0x1b, 0x34]) + _byte_repeat(0xab, 72500),
            ]
        },

        # array
        {
            name = "empty array",
            value = [],
            msgpack = [
                PoolByteArray([0x90]),
                PoolByteArray([0xdc, 0x00, 0x00]),
                PoolByteArray([0xdd, 0x00, 0x00, 0x00, 0x00]),
            ]
        },
        {
            name = "array [1, 2, 3]",
            value = [1, 2, 3],
            msgpack = [
                PoolByteArray([0x93, 0x01, 0x02, 0x03]),
                PoolByteArray([0xdc, 0x00, 0x03, 0x01, 0x02, 0x03]),
                PoolByteArray([0xdd, 0x00, 0x00, 0x00, 0x03, 0x01, 0x02, 0x03]),
            ]
        },
        {
            name = "array 500 integer '42'",
            value = _array_repeat(42, 500),
            msgpack = [
                PoolByteArray([0xdc, 0x01, 0xf4]) + _byte_repeat(42, 500),
                PoolByteArray([0xdd, 0x00, 0x00, 0x01, 0xf4]) + _byte_repeat(42, 500),
            ]
        },
        {
            name = "array 66000 integer '123'",
            value = _array_repeat(123, 66000),
            msgpack = [
                PoolByteArray([0xdd, 0x00, 0x01, 0x01, 0xd0]) + _byte_repeat(123, 66000),
            ]
        },

        # map
        {
            name = "empty map",
            value = {},
            msgpack = [
                PoolByteArray([0x80]),
                PoolByteArray([0xde, 0x00, 0x00]),
                PoolByteArray([0xdf, 0x00, 0x00, 0x00, 0x00]),
            ]
        },
        {
            name = "map {foo = 1, bar = 2}",
            value = {foo = 1, bar = 2},
            msgpack = [
                PoolByteArray([0x82, 0xa3, 0x66, 0x6f, 0x6f, 0x01, 0xa3, 0x62, 0x61, 0x72, 0x02]),
                PoolByteArray([0xde, 0x00, 0x02, 0xa3, 0x66, 0x6f, 0x6f, 0x01, 0xa3, 0x62, 0x61, 0x72, 0x02]),
                PoolByteArray([0xdf, 0x00, 0x00, 0x00, 0x02, 0xa3, 0x66, 0x6f, 0x6f, 0x01, 0xa3, 0x62, 0x61, 0x72, 0x02]),
            ]
        },
    ]

func _byte_repeat(byte, length):
    var buffer = StreamPeerBuffer.new()
    for i in range(length):
        buffer.put_u8(byte)
    return buffer.data_array

func _string_repeat(ch, length):
    var s = ""
    for i in range(length):
        s += ch
    return s

func _array_repeat(item, length):
    var a = []
    for i in range(length):
        a.append(item)
    return a

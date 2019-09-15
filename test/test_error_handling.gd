
var Util = load("res://test/utils.gd")

func run(module):
    var success_count = 0
    print("[#] Testing error handling")

    success_count = 0
    print("* Test detect error in encoding")
    for case in encode_testcases():
        var res = module.encode(case.value)
        if res.error == OK:
            print(" * Failed to catch error in %s" % [case.name])
            print("   %s" % [case.value])
        else:
            success_count += 1
    print()
    print("%s testcases passed" % [success_count])
    print()

    success_count = 0
    print("* Test detect error in decoding")
    for case in decode_testcases():
        var res = module.decode(case.value)
        if res.error == OK:
            print(" * Failed to catch error in %s" % [case.name])
            print("   %s" % [case.value])
        else:
            # print(res.error_string)
            success_count += 1
    print()
    print("%s testcases passed" % [success_count])

func encode_testcases():
    return [
        {
            name = "invalid data type Vector2",
            value = Vector2()
        },
    ]

func decode_testcases():
    return [
        {
            name = "empty binary",
            value = PoolByteArray([])
        },
        {
            name = "invalid byte tag",
            value = PoolByteArray([0xc1])
        },
        {
            name = "not enough byte to read int64",
            value = PoolByteArray([0xd3, 0x00, 0x00, 0x00])
        },
        {
            name = "too many byte",
            value = PoolByteArray([0x01, 0x02])
        },
        {
            name = "string size mismatch",
            value = PoolByteArray([0xa5, 0x61, 0x65, 0x6c, 0x6c])
            # supposed to a the string 'hello' but the last L is missing
        },
    ]

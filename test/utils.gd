
static func to_hex(bytes):
    var s = ""
    for i in range(bytes.size()):
        s += "%02X" % [bytes[i]]
        if i < bytes.size() - 1:
            s += " "
    return s

static func equals(a, b):
    var epsilon = 0.001
    if typeof(a) == TYPE_REAL or typeof(b) == TYPE_REAL:
        return abs(a - b) <= epsilon
    elif typeof(a) == TYPE_DICTIONARY and typeof(b) == TYPE_DICTIONARY:
        return a.hash() == b.hash()
    else:
        return a == b

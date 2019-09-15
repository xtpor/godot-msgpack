extends SceneTree

var TestPackUnpack = preload("res://test/test_pack_unpack.gd")
var TestErrorHandling = preload("res://test/test_error_handling.gd")
var Msgpack = preload("res://msgpack.gd")

func _init():
    var test1 = TestPackUnpack.new()
    test1.run(Msgpack)

    var test2 = TestErrorHandling.new()
    test2.run(Msgpack)

    quit()

extends Node

var _current_scene = null
var save: SaveSlot

func _ready():
	var root = get_tree().root
	_current_scene = root.get_child(root.get_child_count() - 1)

func switch_map_scene(path: String, load: SaveSlot = null):
	call_deferred("_deffered_switch_map_scene", path, load)

func _deffered_switch_map_scene(path: String, load: SaveSlot = null):
	_current_scene.free()
	var s = load(path)
	_current_scene = s.instantiate()
	get_tree().root.add_child(_current_scene)
	get_tree().current_scene = _current_scene
	_current_scene.initiate(load)

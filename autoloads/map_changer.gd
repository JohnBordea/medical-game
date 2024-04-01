extends Node

var _current_scene = null

func _ready():
	var root = get_tree().root
	_current_scene = root.get_child(root.get_child_count() - 1)

func switch_map_scene(path: String, coordinates: Vector2):
	call_deferred("_deffered_switch_map_scene", path, coordinates)

func _deffered_switch_map_scene(path: String, coordinates: Vector2):
	_current_scene.free()
	var s = load(path)
	_current_scene = s.instantiate()
	get_tree().root.add_child(_current_scene)
	get_tree().current_scene = _current_scene
	_current_scene.initiate(coordinates)

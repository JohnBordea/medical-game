extends Node2D
class_name MapBase

signal map_scene_change(path: String, coord: Vector2)

@onready var player = %Player
@onready var doors = %Doors

func initiate_doors():
	for door in doors.get_children():
		door.map_scene_change.connect(_on_map_scene_change)

func initiate(coordinates: Vector2):
	player.position = coordinates
	if doors != null:
		initiate_doors()

func _on_map_scene_change(path: String, coord: Vector2):
	emit_signal("map_scene_change", path, coord)

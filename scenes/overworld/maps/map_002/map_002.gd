extends Node2D

signal map_scene_change(path: String, coord: Vector2)

@onready var player = %Player
@onready var doors = %Doors

var scene_change: bool = false

func initiate_doors():
	for door in doors.get_children():
		door.map_scene_change.connect(_on_map_scene_change)

func initiate(coordinates: Vector2):
	player.position = coordinates
	if doors != null:
		initiate_doors()

func _on_map_scene_change(path: String, coord: Vector2):
	if not scene_change:
		scene_change = true
		emit_signal("map_scene_change", path, coord)

extends Area2D

signal map_scene_change(path: String, coord: Vector2)

@export_category("Go To")
@export var path: String
@export var coordinates: Vector2

func _on_body_entered(body):
	emit_signal("map_scene_change", path, coordinates)

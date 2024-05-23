extends CanvasLayer

@onready var log_container = %LogContainer

@export var log_scene: PackedScene

func _ready():
	CombatBase.move_made.connect(_on_log_made)

func initiate():
	for child in log_container.get_children():
		child.queue_free()

func _on_log_made(log: String):
	var new_log = log_scene.instantiate()
	log_container.add_child(new_log)
	log_container.move_child(new_log, 0)
	new_log.text = log

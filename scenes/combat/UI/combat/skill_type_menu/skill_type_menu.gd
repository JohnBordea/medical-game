extends CanvasLayer

signal type_chosen(type: SkillType)
signal back

@onready var type_container = %TypeContainer

@export var button_scene: PackedScene

func _input(event):
	if visible:
		if Input.is_action_just_released("escape"):
			emit_signal("back")

func initiate(types: Array[SkillType]):
	for child in type_container.get_children():
		child.queue_free()

	for type in types:
		var button = button_scene.instantiate()
		type_container.add_child(button)
		button.initiate(type)
		button.was_pressed.connect(_on_type_chosen)

func _on_type_chosen(type: SkillType):
	emit_signal("type_chosen", type)

func _on_back_pressed():
	emit_signal("back")

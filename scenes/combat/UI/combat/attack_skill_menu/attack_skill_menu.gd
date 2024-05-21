extends CanvasLayer

signal skill_chosen(type: SkillBase)
signal back

@onready var skill_container = %SkillContainer

@export var button_scene: PackedScene

func _input(event):
	if Input.is_action_just_released("escape"):
		emit_signal("back")

func initiate(skills: Array[SkillBase]):
	for child in skill_container.get_children():
		child.queue_free()

	for skill in skills:
		var button = button_scene.instantiate()
		skill_container.add_child(button)
		button.initiate(skill)
		button.was_pressed.connect(_on_skill_chosen)

func _on_skill_chosen(skill: SkillBase):
	emit_signal("skill_chosen", skill)

func _on_back_pressed():
	emit_signal("back")

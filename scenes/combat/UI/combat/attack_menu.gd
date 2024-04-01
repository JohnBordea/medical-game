extends CanvasLayer

signal skill_chosen(player: CombatEntity, skill: SkillBase)

@onready var skill_container = %SkillContainer

@export var skill_button: PackedScene

var data: CombatEntity

func initiate(player: CombatEntity):
	data = player
	for i in skill_container.get_children():
		i.queue_free()

	for i in data.skills:
		var button = skill_button.instantiate()
		skill_container.add_child(button)
		button.initiate(i)
		button.was_pressed.connect(_on_skill_chosen)

func _on_skill_chosen(skill: SkillBase):
	emit_signal("skill_chosen", data, skill)

extends Control

signal quest_chosen(quest: QuestBase)

@onready var sprite = %Sprite

var quest: QuestBase

var mouse_on: bool = false

func initiate(quest: QuestBase):
	self.quest = quest
	position = quest.coordinates
	sprite.texture = load(quest.image)

func _process(delta):
	if mouse_on and Input.is_action_just_released("left_click"):
		emit_signal("quest_chosen", quest)
	if quest and quest.solved:
		sprite.modulate = Color("00fc33")

func _on_mouse_entered():
	mouse_on = true

func _on_mouse_exited():
	mouse_on = false

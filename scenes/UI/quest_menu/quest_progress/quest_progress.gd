extends MarginContainer

@onready var title = %Title
@onready var description = %Description
@onready var progress_container = %ProgressContainer
@onready var validator = %Validator
@onready var quest_scroll_container = %QuestScrollContainer

var quest: QuestBase

func initiate(quest_init: QuestBase):
	quest = quest_init
	title.text = quest.title
	description.text = quest.description

	quest_scroll_container.initiate(quest_init.progress)

	if quest.solved:
		validator.disabled = true
		validator.text = "Solved"
	elif not quest.is_unlocked():
		validator.disabled = true
		validator.text = "Locked"
	else:
		validator.disabled = false
		validator.text = "Solve"

func _on_validator_pressed():
	quest.solve_quest()
	if quest.solved:
		validator.disabled = true
		validator.text = "Solved"

func _trim_top(height: int):
	size = Vector2(size.x, size.y - height)

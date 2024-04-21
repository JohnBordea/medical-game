extends MarginContainer

@onready var title = %Title
@onready var description = %Description
@onready var progress_container = %ProgressContainer
@onready var validator = %Validator

var quest: QuestBase

func initiate(quest_init: QuestBase):
	quest = quest_init
	title.text = quest.title
	description.text = quest.description

	for item in progress_container.get_children():
		item.queue_free()

	for progress in quest.progress:
		var progress_title_panel = PanelContainer.new()
		var progress_title = Label.new()
		progress_container.add_child(progress_title_panel)
		progress_title_panel.add_child(progress_title)
		progress_title.text = progress.title
		for action in progress.actions:
			var action_label = Label.new()
			progress_container.add_child(action_label)
			action_label.text = action.character_class + " " + action.item.title + " " + str(action._amount_completed) + "/" + str(action.amount)

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

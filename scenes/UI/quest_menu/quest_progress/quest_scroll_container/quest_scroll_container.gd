extends ScrollContainer

@onready var progress_container = %ProgressContainer

func initiate(quest_progress: Array[QuestProgressBase]):
	for item in progress_container.get_children():
		item.queue_free()

	for progress in quest_progress:
		var progress_title_panel = PanelContainer.new()
		var progress_title = Label.new()
		progress_container.add_child(progress_title_panel)
		progress_title_panel.add_child(progress_title)
		progress_title.text = progress.title
		for action in progress.actions:
			var action_label = Label.new()
			progress_container.add_child(action_label)
			action_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
			action_label.size.x = 250
			action_label.text = action.character_class + " " + action.item.title + " " + str(action._amount_completed) + "/" + str(action.amount)

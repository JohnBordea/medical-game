extends MarginContainer

@onready var progress = %Progress

func initiate():
	var quest_solved = 0
	for quest in Config.global_quests:
		if quest.solved:
			quest_solved += 1
	progress.text = "Quests solved: " + str(quest_solved) + "/" + str(Config.global_quests.size()) + ""

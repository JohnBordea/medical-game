extends MarginContainer

@onready var general_progress = %GeneralProgress
@onready var quest_progress = %QuestProgress
@onready var quest_panel = %QuestPanel

func _ready():
	initiate()
	quest_panel.quest_chosen.connect(_on_quest_chosen)

func initiate():
	general_progress.visible = true
	general_progress.initiate()
	quest_progress.visible = false
	quest_panel.initiate()

func _on_quest_chosen(quest: QuestBase):
	general_progress.visible = false
	quest_progress.visible = true
	quest_progress.initiate(quest)

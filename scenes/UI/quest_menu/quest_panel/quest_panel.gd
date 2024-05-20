extends MarginContainer

signal quest_chosen(quest: QuestBase)

@onready var quest_item_list = %QuestItemList
@onready var quest_item_conections = %QuestItemConections
@onready var control = %Control
@onready var quest_item_scroll_container = %QuestItemScrollContainer

@export var quest_item_instance: PackedScene

func _ready():
	quest_item_scroll_container.size = Vector2(802, 588)

func initiate():
	var control_x = 0
	for quest in Config.global_quests:
		var quest_item = quest_item_instance.instantiate()
		quest_item_list.add_child(quest_item)
		quest_item.initiate(quest)
		quest_item.quest_chosen.connect(_on_quest_chosen)
		if control_x < (quest.coordinates.x + 64):
			control_x = quest.coordinates.x + 64
		if not quest.prerequesites.is_empty():
			for prerequesite in quest.prerequesites:
				var line = Line2D.new()
				quest_item_conections.add_child(line)
				line.width = 20
				var point_1 = quest.coordinates
				var point_2 = prerequesite.coordinates
				if point_1.x > point_2.x:
					var temp = point_1
					point_1 = point_2
					point_2 = temp
				line.add_point(point_1 + Vector2(128, 64))
				line.add_point(point_2 + Vector2(0, 64))
	control.size.x = control_x + 50

func _on_quest_chosen(quest: QuestBase):
	emit_signal("quest_chosen", quest)

func _trim_top(height: int):
	#size.y -= height
	size = Vector2(size.x, size.y - height)
	#quest_item_scroll_container.size.y -= height
	quest_item_scroll_container.size = Vector2(quest_item_scroll_container.size.x, quest_item_scroll_container.size.y - height)
	#quest_item_scroll_container._set_size(quest_item_scroll_container.size - Vector2(0, height))

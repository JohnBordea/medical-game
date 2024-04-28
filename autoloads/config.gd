extends Node

signal show_pop_up(title: String)
signal hide_pop_up(title: String)

enum SkillType{
	PHYSICAL,
	BUFF
}

var local_save: SaveSlot

var global_npc_locations: Array[NPCBase]
var global_quests: Array[QuestBase] = []

func _ready():
	pass

func initiate(load: SaveSlot = null):
	if load == null:
		local_save = ResourceLoader.load("res://resources/save_system/saves/default_save.tres") as SaveSlot
	else:
		local_save = load
	global_quests = local_save.quest_list
	print(local_save.maps_positioning)

func quest_checker(item: Resource):
	for quest in global_quests:
		if quest.is_unlocked():
			quest.check(item)

func show_quests():
	for quest in global_quests:
		quest.print_debug()

func show_hover_pop_up(title: String):
	emit_signal("show_pop_up", title)

func hide_hover_pop_up(title: String):
	emit_signal("hide_pop_up", title)

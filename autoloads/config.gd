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

func add_test_to_save(npc: NPCBase, test: Test, result: String):
	var npc_location = _get_npc_location(npc)
	if npc_location:
		npc_location.tests_taken.insert(0, test)
		npc_location.tests_taken_results.insert(0, result)

func add_diagnostic_to_save(npc: NPCBase, result: bool):
	var npc_location = _get_npc_location(npc)
	if npc_location:
		npc_location.diagnostic_made = result

func _get_npc_location(npc: NPCBase) -> NPCLocation:
	for map_positioning in local_save.maps_positioning:
		for npc_location in map_positioning.npc_location:
			if npc_location.npc == npc:
				return npc_location
	return null

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

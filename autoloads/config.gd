extends Node

signal show_pop_up(title: String)
signal hide_pop_up(title: String)

enum SkillType{
	PHYSICAL,
	BUFF
}

var local_map_path: String
var local_map_coordinates: Vector2
var local_save: SaveSlot
var all_saves: Array[SaveSlot]

var global_npc_locations: Array[NPCBase]
var global_quests: Array[QuestBase] = []

func _ready():
	var paths = _get_all_files("res://resources/save_system/saves/all_saves/", ".tres")
	for path in paths:
		var save = load(path) as SaveSlot
		all_saves.append(save)
	all_saves.sort_custom(
		func (a: Node, b: Node):
			return a.data.date > b.data.date
	)

func initiate(load: SaveSlot = null):
	if load == null:
		local_save = ResourceLoader.load("res://resources/save_system/saves/default_save.tres") as SaveSlot
	else:
		local_save = load
	local_map_path = local_save.map_path
	local_map_coordinates = local_save.player_coord
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

func _get_all_files(path: String, sufix: String):
	var dir = DirAccess.open(path)
	var paths = []
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if not dir.current_is_dir():
				if file_name.ends_with(sufix):
					paths.append(path + file_name)
			file_name = dir.get_next()
	return paths

func add_new_save_slot(save: SaveSlot):
	ResourceSaver.save(save, "res://resources/save_system/saves/all_saves/" + save.name + ".tres")
	for save_slot in all_saves:
		if save.name == save_slot.name:
			all_saves.erase(save_slot)
	all_saves.append(save)
	all_saves.sort_custom(
		func (a: Node, b: Node):
			return a.data.date > b.data.date
	)

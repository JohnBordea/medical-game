extends Node2D

@onready var map = %Map
@onready var patient_data_ui = %PatientDataUI
@onready var combat = %Main
@onready var camera = %Camera
@onready var quest_menu = %QuestMenu
@onready var save_menu = %SaveMenu

var current_node: Node
var _what_window_open: Node

var player_node: Node2D
var _is_camera_on_player: bool = true

func _ready():
	DialogueManagerGlobal.start_treatment_menu.connect(_on_start_treatment_menu)
	patient_data_ui.take_diagnostic.connect(_on_take_diagnostic)
	patient_data_ui.cancel.connect(_on_diagnostic_cancel)
	CombatBase.game_over.connect(_on_game_over)
	_what_window_open = map
	initiate()

func _process(delta):
	if _is_camera_on_player:
		camera.global_position = player_node.global_position
	else:
		camera.global_position = Vector2(577, 324)
	if Input.is_action_just_released("quest_menu"):
		_on_quest_menu_activate()
	if Input.is_action_just_released("save_menu"):
		_on_save_menu_activate()

func initiate(load: SaveSlot = null):
	Config.initiate(load)
	camera.zoom = Vector2(2, 2)
	
	#map generator
	for map_scene in map.get_children():
		map_scene.queue_free()
	
	var map_instantiator = load(Config.local_save.map_path)
	var map_scene = map_instantiator.instantiate()
	map.add_child(map_scene)
	map_scene.initiate(Config.local_save.player_coord)
	map_scene.map_scene_change.connect(_on_map_scene_change)

	player_node = map_scene.player

func _on_start_treatment_menu(npc: NPCBase):
	_scene_change_from_to(patient_data_ui, 1)

	patient_data_ui.initiate(npc)
	DialogueManagerGlobal.end_dialogue()

func _on_take_diagnostic():
	if DialogueManagerGlobal.npc.illness.combat_entity != null:
		_is_camera_on_player = false
		camera.zoom = Vector2(1, 1)

		_scene_change_from_to(combat)
		patient_data_ui.visible = false
		combat.visible = true

		combat.initiate(DialogueManagerGlobal.npc.illness.combat_entity)
	else:
		_is_camera_on_player = true
		camera.zoom = Vector2(2, 2)

		_scene_change_from_to(map, 2)

		DialogueManagerGlobal.npc.cured = true
		Config.quest_checker(DialogueManagerGlobal.npc.illness)

func _on_diagnostic_cancel():
	_is_camera_on_player = true
	camera.zoom = Vector2(2, 2)

	_scene_change_from_to(map, 2)

func _on_game_over(winner: CombatEntity = null):
	_is_camera_on_player = true
	camera.zoom = Vector2(2, 2)

	_scene_change_from_to(map, 2)

	if DialogueManagerGlobal.npc.illness.combat_entity != winner:
		DialogueManagerGlobal.npc.cured = true
	Config.quest_checker(DialogueManagerGlobal.npc.illness)

func _on_map_scene_change(path: String, coord: Vector2):
	call_deferred("_on_map_scene_change_defered", path, coord)

func _on_map_scene_change_defered(path: String, coord: Vector2):
	Config.local_map_path = path
	#TODO
	#delete cured npcs
	for map_scene in map.get_children():
		map_scene.reset_npcs_if_possible()
		map_scene.queue_free()
	var scene = load(path)
	var new_map = scene.instantiate()
	map.add_child(new_map)
	new_map.initiate(coord)
	new_map.map_scene_change.connect(_on_map_scene_change)
	player_node = new_map.player

func _on_quest_menu_activate():
	if _what_window_open == map:
		_scene_change_from_to(quest_menu)
		quest_menu.initiate()
	elif _what_window_open == quest_menu:
		_scene_change_from_to(map)
	elif _what_window_open == save_menu:
		_scene_change_from_to(quest_menu)
		quest_menu.initiate()

func _on_save_menu_activate():
	if _what_window_open == map:
		_scene_change_from_to(save_menu)
		Config.local_map_coordinates = player_node.position
		save_menu.initiate()
	elif _what_window_open == save_menu:
		_scene_change_from_to(map)
	elif _what_window_open == quest_menu:
		_scene_change_from_to(save_menu)
		Config.local_map_coordinates = player_node.position
		save_menu.initiate()

func _scene_change_from_to(scene_to: Node, who_to_change_process: int = -1):
	_what_window_open.visible = false
	scene_to.visible = true

	#TODO
	#When out of map to not be able to move
	if who_to_change_process == 1:
		_what_window_open.set_process(not _what_window_open.is_processing())
	elif who_to_change_process == 2:
		scene_to.set_process(not scene_to.is_processing())

	_what_window_open = scene_to

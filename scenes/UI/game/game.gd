extends Node2D

@onready var map = %Map
@onready var patient_data_ui = %PatientDataUI
@onready var combat = %Main
@onready var camera = %Camera
@onready var quest_menu = %QuestMenu
@onready var save_menu = %SaveMenu
@onready var load_save_menu = %LoadSaveMenu
@onready var general_menu = %GeneralMenu

var current_node: Node
var _what_window_open: Node

var player_node: Node2D
var _is_camera_on_player: bool = true
var _is_menu_accesible: bool = true

func _ready():
	DialogueManagerGlobal.start_treatment_menu.connect(_on_start_treatment_menu)
	patient_data_ui.take_diagnostic.connect(_on_take_diagnostic)
	patient_data_ui.cancel.connect(_on_diagnostic_cancel)
	general_menu.option_made.connect(_on_option_made)
	load_save_menu.back.connect(_on_menu_cancel)
	load_save_menu.load_save.connect(_on_load_save)
	CombatBase.game_over.connect(_on_game_over)
	_scene_change_from_to(map)
	_is_menu_accesible = true
	general_menu.visible = true

func _process(delta):
	if _is_camera_on_player:
		camera.global_position = player_node.global_position - Vector2(0, 17)
	else:
		camera.global_position = Vector2(577, 324)
	if _is_menu_accesible:
		if Input.is_action_just_released("quest_menu"):
			_scene_change_from_to(quest_menu)
		if Input.is_action_just_released("save_menu"):
			_scene_change_from_to(save_menu)
		if Input.is_action_just_released("load_menu"):
			_scene_change_from_to(load_save_menu)
		if Input.is_action_just_released("map") or Input.is_action_just_released("escape"):
			_scene_change_from_to(map)

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
	_scene_change_from_to(patient_data_ui)

	patient_data_ui.initiate(npc)
	DialogueManagerGlobal.end_dialogue()

func _on_menu_cancel():
	_scene_change_from_to(map)

func _on_load_save(data: SaveSlot):
	MapChanger.switch_map_scene("res://scenes/UI/game/game.tscn", data)

func _on_take_diagnostic():
	if DialogueManagerGlobal.npc.illness.combat_entity != null:
		_is_camera_on_player = false
		camera.zoom = Vector2(1, 1)

		_scene_change_from_to(combat)
		patient_data_ui.visible = false
		combat.visible = true

		#combat.initiate(DialogueManagerGlobal.npc.illness.combat_entity)
		combat.initiate(DialogueManagerGlobal.npc.illness)
	else:
		_scene_change_from_to(map)

		DialogueManagerGlobal.npc.cured = true
		Config.quest_checker(DialogueManagerGlobal.npc.illness)

func _on_diagnostic_cancel():
	_scene_change_from_to(map)

func _on_game_over(winner: CombatEntity = null):
	_scene_change_from_to(map)

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

func _on_option_made(simbol: String):
	match simbol:
		"K":
			_scene_change_from_to(save_menu)
		"L":
			_scene_change_from_to(load_save_menu)
		"J":
			_scene_change_from_to(quest_menu)
		"M":
			_scene_change_from_to(map)

func _scene_change_from_to(scene_to: Node):
	if _what_window_open:
		_what_window_open.visible = false

	if _what_window_open == scene_to:
		_what_window_open = map
	else:
		_what_window_open = scene_to
	
	_what_window_open.visible = true
	
	match _what_window_open:
		map:
			_is_camera_on_player = true
			camera.zoom = Vector2(2, 2)
			_is_menu_accesible = true
			general_menu.visible = true
		patient_data_ui:
			_is_menu_accesible = false
			general_menu.visible = false
		save_menu:
			Config.local_map_coordinates = player_node.position
			save_menu.initiate()
			general_menu.visible = false
		quest_menu:
			quest_menu.initiate()
			general_menu.visible = false
		load_save_menu:
			load_save_menu.initiate()
			general_menu.visible = false

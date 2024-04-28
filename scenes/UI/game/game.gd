extends Node2D

@onready var map = %Map
@onready var patient_data_ui = %PatientDataUI
@onready var combat = %Main
@onready var camera = %Camera
@onready var quest_menu = %QuestMenu

enum window_open {
	MAP,
	PATIENT_DATA,
	COMBAT
}

var player_node: Node2D
var _is_camera_on_player: bool = true
var _what_window_open: window_open

func _ready():
	DialogueManagerGlobal.start_treatment_menu.connect(_on_start_treatment_menu)
	patient_data_ui.take_diagnostic.connect(_on_take_diagnostic)
	CombatBase.game_over.connect(_on_game_over)
	initiate()

func _process(delta):
	if _is_camera_on_player:
		camera.global_position = player_node.global_position
	else:
		camera.global_position = Vector2(577, 324)
	if Input.is_action_just_released("quest_menu"):
		_on_quest_menu_activate()

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
	map.visible = false
	patient_data_ui.visible = true
	patient_data_ui.initiate(npc)

func _on_take_diagnostic():
	_is_camera_on_player = false
	camera.zoom = Vector2(1, 1)
	patient_data_ui.visible = false
	combat.visible = true
	combat.initiate(DialogueManagerGlobal.npc.illness.combat_entity)

func _on_game_over(winner: CombatEntity):
	_is_camera_on_player = true
	camera.zoom = Vector2(2, 2)
	combat.visible = false
	map.visible = true
	if DialogueManagerGlobal.npc.illness.combat_entity != winner:
		DialogueManagerGlobal.npc.cured = true
	#TODO
	Config.quest_checker(DialogueManagerGlobal.npc.illness)
	#Config.show_quests()

	DialogueManagerGlobal.end_dialogue()

func _on_map_scene_change(path: String, coord: Vector2):
	call_deferred("_on_map_scene_change_defered", path, coord)

func _on_map_scene_change_defered(path: String, coord: Vector2):
	for map_scene in map.get_children():
		map_scene.queue_free()
	var scene = load(path)
	var new_map = scene.instantiate()
	map.add_child(new_map)
	new_map.initiate(coord)
	new_map.map_scene_change.connect(_on_map_scene_change)
	player_node = new_map.player

func _on_quest_menu_activate():
	if quest_menu.visible:
		map.visible = true
		quest_menu.visible = false
	else:
		map.visible = false
		quest_menu.visible = true
		quest_menu.initiate()

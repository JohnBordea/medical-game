extends Node2D

@onready var map = %Map
@onready var patient_data_ui = %PatientDataUI
@onready var combat = %Main
@onready var camera = %Camera

var player_node: Node2D

var _is_camera_on_player: bool = true

func _ready():
	DialogueManagerGlobal.start_treatment_menu.connect(_on_start_treatment_menu)
	patient_data_ui.take_diagnostic.connect(_on_take_diagnostic)
	CombatBase.game_over.connect(_on_game_over)
	camera.zoom = Vector2(2, 2)
	
	for map_scene in map.get_children():
		map_scene.initiate_doors()
		map_scene.map_scene_change.connect(_on_map_scene_change)
	player_node = map.get_child(0).player

func _process(delta):
	if _is_camera_on_player:
		camera.global_position = player_node.global_position
	else:
		camera.global_position = Vector2(577, 324)

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
	DialogueManagerGlobal.end_dialogue()

func _on_map_scene_change(path: String, coord: Vector2):
	for map_scene in map.get_children():
		map_scene.queue_free()
	var scene = load(path)
	var new_map = scene.instantiate()
	map.add_child(new_map)
	new_map.initiate_doors()
	new_map.initiate(coord)
	player_node = new_map.player

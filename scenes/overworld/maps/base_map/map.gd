extends Node2D
class_name MapBase

signal map_scene_change(path: String, coord: Vector2)

@onready var player = %Player
@onready var doors = %Doors
@onready var npc_s = %NPCs

@export var npc_instance: PackedScene

var scene_change: bool = false

func initiate_doors():
	for door in doors.get_children():
		door.map_scene_change.connect(_on_map_scene_change)

func initiate_npcs():
	for location in Config.local_save.maps_positioning:
		if location.map_name == self.scene_file_path:
			for npc_location in location.npc_location:
				if npc_location.npc == null:
					#Create NPC
					var npc = NPCBase.new()
					npc.name = "Default Case"
					npc.generate_data(location.posible_illneses)
					npc_location.npc = npc
				var npc = npc_instance.instantiate()
				npc_s.add_child(npc)
				npc.initiate(npc_location.npc)
				npc.position = npc_location.position

func reset_npcs_if_possible():
	for node in npc_s.get_children():
		if node is NPC:
			_on_reset_npc_instance(node)

func _on_reset_npc_instance(node: NPC):
	var npc_data = node.data
	for location in Config.local_save.maps_positioning:
		if location.map_name == self.scene_file_path:
			for npc_location in location.npc_location:
				if npc_location.npc != null and npc_location.npc.cured:
					npc_location.npc = null
					npc_location.tests_taken.clear()
					npc_location.tests_taken_results.clear()
					npc_location.diagnostic_made = false

func initiate(coordinates: Vector2):
	player.position = coordinates
	if doors != null:
		initiate_doors()
	initiate_npcs()

func _on_map_scene_change(path: String, coord: Vector2):
	if not scene_change:
		scene_change = true
		emit_signal("map_scene_change", path, coord)

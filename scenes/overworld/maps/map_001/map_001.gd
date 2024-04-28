extends Node2D

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
					npc.gender = "M"
					npc.age = 99
					if location.posible_illneses.is_empty():
						npc.cured = true
					else:
						npc.cured = false
						npc.illness = location.posible_illneses.pick_random()
					npc.dialogue = load("res://resources/dialogues/NPC.dialogue") as DialogueResource
					npc.dialogue_start = "content"
					npc_location.npc = npc
				var npc = npc_instance.instantiate()
				npc_s.add_child(npc)
				npc.initiate(npc_location.npc)
				npc.position = npc_location.position

func initiate(coordinates: Vector2):
	player.position = coordinates
	if doors != null:
		initiate_doors()
	initiate_npcs()

func _on_map_scene_change(path: String, coord: Vector2):
	if not scene_change:
		scene_change = true
		emit_signal("map_scene_change", path, coord)

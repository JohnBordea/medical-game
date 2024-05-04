extends Resource
class_name NPCBase

@export_global_file("*.png") var sprite = "res://resources/npc_data/default_icon.png"
@export var name: String
@export var gender: String
@export var age: int
@export var illness: IllnessBase
@export var cured: bool = false
@export var dialogue: DialogueResource
@export var dialogue_start: String
@export var map: PackedScene

func cure():
	cured = true
	emit_signal("npc_cured")

func generate_default_data(posible_illneses: Array[IllnessBase]):
	name = "Default Case"
	gender = "M"
	age = 99
	if posible_illneses.is_empty():
		cured = true
	else:
		cured = false
		illness = posible_illneses.pick_random()
	dialogue = load("res://resources/dialogues/NPC.dialogue") as DialogueResource
	dialogue_start = "content"

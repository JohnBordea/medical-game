extends Resource
class_name NPCBase

@export_global_file("*.png") var sprite_body = "res://resources/npc_data/sprites/body/sprite_default.png"
@export_global_file("*.png") var sprite_hair = "res://resources/npc_data/sprites/hair/adult/sprite_hair_00.png"
#@export_global_file("*.png") var sprite = "res://resources/npc_data/default_icon.png"
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

func generate_default_data():
	name = "Default Case"
	gender = "M"
	age = 99
	cured = true
	dialogue = load("res://resources/dialogues/NPC.dialogue") as DialogueResource
	dialogue_start = "content"

func generate_data(posible_illneses: Array[IllnessBase]):
	if posible_illneses == null or posible_illneses.is_empty():
		generate_default_data()
	else:
		cured = false
		illness = posible_illneses.pick_random()
		if randf() < illness.gender:
			gender = "Male"
		else:
			gender = "Female"
		var age_vars = illness.age.pick_random()
		age = randi_range(age_vars[0], age_vars[1])
		generate_sprite()
		dialogue = load("res://resources/dialogues/NPC.dialogue") as DialogueResource
		dialogue_start = "content"

func generate_sprite():
	var sprite = "res://resources/npc_data/sprites/"
	var sprite_body_name = "body/sprite_"
	if age <= 12:
		sprite_body_name += "child_"
	elif age <= 18:
		sprite_body_name += "teen_"
	elif age <= 60:
		sprite_body_name += "adult_"
	else:
		sprite_body_name += "old_"
	
	if gender == "Male":
		sprite_body_name += "male.png"
	elif gender == "Female":
		sprite_body_name += "female.png"
	sprite_body = sprite + sprite_body_name

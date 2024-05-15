extends Entity
class_name NPC

@onready var body = %Body
@onready var hair = %Hair

@export var dialogue: DialogueResource
@export var dialogue_start: String = ""
@export var data: NPCBase

func initiate(new_data: NPCBase):
	data = new_data
	dialogue = data.dialogue
	dialogue_start = data.dialogue_start
	body.texture = load(data.sprite_body)
	hair.texture = load(data.sprite_hair)

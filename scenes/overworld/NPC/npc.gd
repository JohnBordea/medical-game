extends Entity
class_name NPC

@export var dialogue: DialogueResource
@export var dialogue_start: String = ""
@export var data: NPCBase

func initiate(new_data: NPCBase):
	data = new_data
	dialogue = data.dialogue
	dialogue_start = data.dialogue_start

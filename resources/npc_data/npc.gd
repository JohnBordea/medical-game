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

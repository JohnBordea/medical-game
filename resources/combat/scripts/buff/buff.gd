extends Resource
class_name Buff

@export var name: String = "Simple Buff"
@export_global_file("*.png") var sprite = "res://resources/combat/obj/skills/misc/buff_base.png"
@export var cooldown: int = -1

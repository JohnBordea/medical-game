extends Resource
class_name SymptomBase

@export_global_file("*.png") var image = "res://resources/illnesses/symptoms/default_icon.png"
@export var name: String
@export var requirenment_type: Config.RequirenmentType
@export var requirenment: Array

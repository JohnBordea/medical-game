extends Resource
class_name Diagnostic

@export_global_file("*.png") var image = "res://resources/tests/default_icon.png"
@export var name: String
@export var description: IllnessBase
@export var default_diagnostic: String = "Nothing Unusual"

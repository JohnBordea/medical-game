extends Control

signal pressed(simbol: String)

@onready var simbol_label = %SimbolLabel
@onready var icon = %Icon

@export_global_file("*.png") var image
@export var simbol: String

func _ready():
	simbol_label.text = simbol
	if image != null:
		icon.texture = load(image)

func _on_button_pressed():
	emit_signal("pressed", simbol)

extends Control

signal pressed(simbol: String)

@onready var selected = %Selected
@onready var simbol_label = %SimbolLabel
@onready var icon = %Icon

@export_global_file("*.png") var image
@export var simbol: String

var is_selected: bool = false

func _ready():
	simbol_label.text = simbol
	if image != null:
		icon.texture = load(image)

func initiate():
	is_not_chosen()

func is_chosen():
	is_selected = true
	selected.visible = true

func is_not_chosen():
	is_selected = false
	selected.visible = false

func _on_button_pressed():
	emit_signal("pressed", simbol)

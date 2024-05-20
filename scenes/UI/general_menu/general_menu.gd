extends CanvasLayer

signal option_made(simbol: String)

@onready var option_menu = %OptionMenu

func _ready():
	for child in option_menu.get_children():
		child.pressed.connect(_on_option_pressed)

func _on_option_pressed(simbol: String):
	print(simbol)
	emit_signal("option_made", simbol)
	choose_option(simbol)

func choose_option(simbol: String):
	for child in option_menu.get_children():
		if simbol == child.simbol:
			child.is_chosen()
		else:
			child.is_not_chosen()

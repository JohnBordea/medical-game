extends MarginContainer

signal chosen(data: SaveSlot)

@onready var load_title = %LoadTitle
@onready var load_date = %LoadDate

var data: SaveSlot

func initiate(new_data: SaveSlot):
	data = new_data
	load_title.text = data.name
	load_date.text = data.date

func _on_button_pressed():
	emit_signal("chosen", data)

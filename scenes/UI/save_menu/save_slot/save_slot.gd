extends MarginContainer

signal chosen(data: SaveSlot)
signal delete(data: SaveSlot)

@onready var save_title = %SaveTitle
@onready var save_date = %SaveDate

var data: SaveSlot

func initiate(new_data: SaveSlot):
	data = new_data
	save_title.text = data.name
	save_date.text = data.date

func _on_button_pressed():
	emit_signal("chosen", data)

func _on_delete_pressed():
	emit_signal("delete", data)

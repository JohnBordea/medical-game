extends PanelContainer

signal link(name: String)

@onready var text_label = %Text

func initiate(name: String):
	text_label.text = name

func _on_button_pressed():
	emit_signal("link", text_label.text)

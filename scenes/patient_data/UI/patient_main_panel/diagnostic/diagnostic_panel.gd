extends PanelContainer

signal diagnostic

@onready var button = $MarginContainer/VBoxContainer/Button

func initiate():
	button.disabled = true

func test_taken():
	button.disabled = false

func _on_button_pressed():
	emit_signal("diagnostic")

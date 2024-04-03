extends Button

signal link(name: String)

func initiate(name: String):
	text = name

func _on_pressed():
	emit_signal("link", text)

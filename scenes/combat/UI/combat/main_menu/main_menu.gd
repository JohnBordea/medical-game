extends CanvasLayer

signal attack
signal analyze

func initiate():
	pass

func _on_attack_pressed():
	emit_signal("attack")

func _on_analyze_pressed():
	emit_signal("analyze")

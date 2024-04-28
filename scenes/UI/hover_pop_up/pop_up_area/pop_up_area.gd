extends Area2D
class_name PopUpArea

@export var title: String = "Random Text"

func _on_mouse_entered():
	Config.show_hover_pop_up(title)

func _on_mouse_exited():
	Config.hide_hover_pop_up(title)

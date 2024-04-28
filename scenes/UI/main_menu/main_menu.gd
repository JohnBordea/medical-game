extends Node2D

func _on_new_game_pressed():
	MapChanger.switch_map_scene("res://scenes/UI/game/game.tscn")

func _on_load_pressed():
	pass # Replace with function body.

func _on_exit_pressed():
	get_tree().quit()

extends Node2D

@onready var main_menu = %MainMenu
@onready var load_save_menu = %LoadSaveMenu

func _ready():
	load_save_menu.back.connect(_on_load_save_back)
	load_save_menu.load_save.connect(_on_load_save_load)

func _on_new_game_pressed():
	MapChanger.switch_map_scene("res://scenes/UI/game/game.tscn")

func _on_load_pressed():
	_scene_change_from_to(main_menu, load_save_menu)
	load_save_menu.initiate()

func _on_load_save_back():
	_scene_change_from_to(load_save_menu, main_menu)

func _on_load_save_load(data: SaveSlot):
	MapChanger.switch_map_scene("res://scenes/UI/game/game.tscn", data)

func _on_exit_pressed():
	get_tree().quit()

func _scene_change_from_to(scene_from: Node, scene_to: Node):
	scene_from.visible = false
	scene_to.visible = true

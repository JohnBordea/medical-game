extends CanvasLayer

@onready var save_container = %SaveContainer
@onready var save_text_edit = %SaveTextEdit
@onready var save = %Save

@export var save_slot_instance: PackedScene

func initiate():
	for node in save_container.get_children():
		node.queue_free()

	for save in Config.all_saves:
		_create_save_slot(save)
	_sort_saves()

func _create_save_slot(save: SaveSlot):
	var save_slot = save_slot_instance.instantiate()
	save_container.add_child(save_slot)
	save_slot.initiate(save)
	save_slot.chosen.connect(_on_save_slot_pressed)

func _on_save_slot_pressed(data: SaveSlot):
	save_text_edit.text = data.name

func _on_save_pressed():
	var local_save = Config.local_save.duplicate(true) as SaveSlot
	if save_text_edit.text == "":
		local_save.name = save_text_edit.placeholder_text
	else:
		local_save.name = save_text_edit.text
	local_save.date = Time.get_datetime_string_from_system()
	local_save.map_path = Config.local_map_path
	local_save.player_coord = Config.local_map_coordinates
	print(Config.local_map_coordinates)
	Config.add_new_save_slot(local_save)
	initiate()

func _sort_saves():
	var sorted_nodes = save_container.get_children()
	sorted_nodes.sort_custom(
		func (a: Node, b: Node):
			return a.data.date > b.data.date
	)
	for node in save_container.get_children():
		save_container.remove_child(node)
	for node in sorted_nodes:
		save_container.add_child(node)

extends CanvasLayer

signal back
signal load_save(data: SaveSlot)

@onready var load_container = %LoadContainer
@onready var load = %Load
@onready var load_chosen_data = %LoadChosenData

@export var load_slot_instance: PackedScene

var load_file: SaveSlot

func initiate():
	load_file = null
	load.disabled = true
	load_chosen_data.text = ""
	
	for node in load_container.get_children():
		node.queue_free()

	for save in Config.all_saves:
		_create_load_slot(save)
	_sort_saves()

func _create_load_slot(save):
	var load_slot = load_slot_instance.instantiate()
	load_container.add_child(load_slot)
	load_slot.initiate(save)
	load_slot.chosen.connect(_on_load_slot_pressed)
	load_slot.delete.connect(_on_load_slot_delete)

func _on_load_slot_pressed(data: SaveSlot):
	load_file = data
	load.disabled = false
	load_chosen_data.text = data.name

func _on_load_slot_delete(data: SaveSlot):
	Config.delete_save_slot(data)
	initiate()

func _sort_saves():
	var sorted_nodes = load_container.get_children()
	sorted_nodes.sort_custom(
		func (a: Node, b: Node):
			return a.data.date > b.data.date
	)
	for node in load_container.get_children():
		load_container.remove_child(node)
	for node in sorted_nodes:
		load_container.add_child(node)

func _on_load_pressed():
	emit_signal("load_save", load_file)

func _on_back_pressed():
	emit_signal("back")

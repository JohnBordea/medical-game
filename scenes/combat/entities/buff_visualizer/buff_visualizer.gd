extends MarginContainer

@onready var buff_container = %BuffContainer

@export var buff_rect: PackedScene

func add_buff(buff: Buff):
	var buff_scene = buff_rect.instantiate()
	buff_container.add_child(buff_scene)
	buff_scene.initiate(buff)

func pop_buff(buff: Buff):
	for i in buff_container.get_children():
		if i.data == buff:
			i.queue_free()
			return

extends PanelContainer

@export var icon: PackedScene

@onready var s_container = %SympthomContainer

func initiate(sympthoms: Array[SymptomBase]):
	for s in s_container.get_children():
		s.queue_free()

	for s in sympthoms:
		var iteration = icon.instantiate()
		s_container.add_child(iteration)
		iteration.initiate(s)

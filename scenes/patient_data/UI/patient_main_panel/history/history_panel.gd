extends PanelContainer

@export var icon: PackedScene

@onready var h_container = %HistoryContainer

func initiate(history: Array[HistoryBase]):
	for h in h_container.get_children():
		h.queue_free()

	for h in history:
		var iteration = icon.instantiate()
		h_container.add_child(iteration)
		iteration.initiate(h)

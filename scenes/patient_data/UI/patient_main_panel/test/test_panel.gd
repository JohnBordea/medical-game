extends PanelContainer

signal take_test

@onready var test_container = %TestContainer

@export var test_made: PackedScene

func initiate(npc: NPCBase):
	for k in test_container.get_children():
		k.queue_free()

func add_test_result(test_made: Test, test_result: String):
	var test = test_made.instantiate()
	test_container.add_child(test)
	test_container.move_child(test, 0)
	test.initiate(test_made, test_result)

func _on_button_pressed():
	emit_signal("take_test")

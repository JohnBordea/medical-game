extends PanelContainer

signal take_test

@onready var test_container = %TestContainer

@export var test_made: PackedScene

func initiate(npc: NPCBase):
	for k in test_container.get_children():
		k.queue_free()

	var npc_location = Config._get_npc_location(npc)
	for i in range(npc_location.tests_taken.size()):
		add_test_result(npc_location.tests_taken[i], npc_location.tests_taken_results[i])

func add_test_result(test_taken: Test, test_result: String):
	var test = test_made.instantiate()
	test_container.add_child(test)
	test_container.move_child(test, 0)
	test.initiate(test_taken, test_result)

func _on_button_pressed():
	emit_signal("take_test")

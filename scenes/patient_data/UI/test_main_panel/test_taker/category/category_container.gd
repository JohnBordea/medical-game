extends PanelContainer

@onready var category_name = %CategoryName
@onready var count = %Count
@onready var category_container = %CategoryContainer

@export var test_instance: PackedScene

func create(category: TestType):
	category_name.text = category.name

	if category.at_least_used_count == 0:
		count.text = ""
	elif category.at_least_used_count == 1:
		count.text = "Need to use at least once"
	else:
		count.text = "Need to use at least " + str(category.at_least_used_count) + " diferent tests"

	for test in category.tests:
		var t = test_instance.instantiate()
		category_container.add_child(t)
		t.initiate(test)

extends PanelContainer

@onready var category_name = %CategoryName
@onready var category_container = %CategoryContainer

@export var test_instance: PackedScene

func create(category: TestType):
	category_name.text = category.name
	for test in category.tests:
		var t = test_instance.instantiate()
		category_container.add_child(t)
		t.initiate(test)

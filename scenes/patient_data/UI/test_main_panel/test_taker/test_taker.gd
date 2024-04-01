extends MarginContainer

@onready var container = %AllCategoryContainer

@export var category_continer: PackedScene

func create(categories: Array[TestType]):
	for category in categories:
		var c = category_continer.instantiate()
		container.add_child(c)
		c.create(category)

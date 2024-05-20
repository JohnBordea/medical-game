extends MarginContainer

@onready var container = %AllCategoryContainer
@onready var scroll_container = $ScrollContainer

@export var category_continer: PackedScene

func create(categories: Array[DiagnosticType]):
	for category in categories:
		var c = category_continer.instantiate()
		container.add_child(c)
		c.create(category)

func move_to(to: String):
	for child in container.get_children():
		if child.category_name.text == to:
			scroll_container.set_deferred("scroll_vertical", child.position.y)
			return

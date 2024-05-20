extends MarginContainer

signal take_test(test: Test)
signal cancel_test

@onready var test_taker = %TestTaker
@onready var link_container = %CategoryLinkContainer
@onready var text_button = %TakeTest

@export var link_button_instance: PackedScene

var test: Test
var categories: Array[TestType]

func _ready():
	DialogueManagerGlobal.test_taken.connect(_on_test_chosen)
	_load_categories()
	for category in categories:
		var new_button = link_button_instance.instantiate()
		link_container.add_child(new_button)
		new_button.initiate(category.name)
		new_button.link.connect(_on_link_category_pressed)
	test_taker.create(categories)

func _on_link_category_pressed(name: String):
	test_taker.move_to(name)

func _load_categories():
	#categories = []
	categories.clear()
	var paths = Config._get_all_files("res://resources/tests/categories/", ".tres")
	for path in paths:
		categories.append(ResourceLoader.load(path) as TestType)
	categories.sort_custom(
		func sorter(a: TestType, b: TestType):
			return a.order < b.order
	)

func initiate():
	test = null
	text_button.disabled = true

func _on_test_chosen(test: Test):
	self.test = test
	text_button.disabled = false

func _on_take_test_pressed():
	emit_signal("take_test", test)

func _on_cancel_pressed():
	emit_signal("cancel_test")

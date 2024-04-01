extends MarginContainer

signal take_test(test: Test)
signal cancel_test

@onready var test_taker = %TestTaker

var test: Test
var categories: Array[TestType]

func _ready():
	DialogueManagerGlobal.test_taken.connect(_on_test_chosen)
	_load_categories()
	test_taker.create(categories)

func _load_categories():
	categories = []
	var paths = _get_all_files("res://resources/tests/categories/")
	for path in paths:
		categories.append(ResourceLoader.load(path) as TestType)

func _get_all_files(path: String):
	var dir = DirAccess.open(path)
	var paths = []
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if not dir.current_is_dir():
				if file_name.ends_with(".tres"):
					paths.append(path + file_name)
			file_name = dir.get_next()
	return paths

func initiate():
	test = null
	%TakeTest.disabled = true

func _on_test_chosen(test: Test):
	self.test = test
	%TakeTest.disabled = false

func _on_take_test_pressed():
	emit_signal("take_test", test)

func _on_cancel_pressed():
	emit_signal("cancel_test")

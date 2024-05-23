extends MarginContainer

signal take_diagnostic(diagnostic: IllnessBase)
signal cancel_diagnostic

@onready var diagnostic_taker = %DiagnosticTaker
@onready var link_container = %CategoryLinkContainer
@onready var category_link_container = %CategoryLinkContainer

@export var link_button_instance: PackedScene

var diagnostic: IllnessBase
var categories: Array[DiagnosticType]

func _ready():
	DialogueManagerGlobal.diagnostic_taken.connect(_on_diagnostic_chosen)
	_load_categories()
	for category in categories:
		var new_button = link_button_instance.instantiate()
		link_container.add_child(new_button)
		new_button.initiate(category.name)
		new_button.link.connect(_on_link_category_pressed)
	diagnostic_taker.create(categories)

func _on_link_category_pressed(name: String):
	diagnostic_taker.move_to(name)

func _load_categories():
	categories = []
	var paths = Config._get_all_files("res://resources/diagnostics/categories/", ".tres")
	for path in paths:
		var item = ResourceLoader.load(path) as DiagnosticType
		categories.append(item)
	categories.sort_custom(
		func sorter(a: DiagnosticType, b: DiagnosticType):
			return a.order < b.order
	)

func initiate():
	diagnostic = null
	%TakeDiagnostic.disabled = true

func _on_diagnostic_chosen(diagnostic: IllnessBase):
	self.diagnostic = diagnostic
	%TakeDiagnostic.disabled = false

func _on_take_diagnostic_pressed():
	emit_signal("take_diagnostic", diagnostic)

func _on_cancel_pressed():
	emit_signal("cancel_diagnostic")

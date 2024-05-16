extends MarginContainer

signal take_diagnostic(diagnostic: IllnessBase)
signal cancel_diagnostic

@onready var diagnostic_taker = %DiagnosticTaker
@onready var link_container = %CategoryLinkContainer

var diagnostic: IllnessBase
var categories: Array[DiagnosticType]

func _ready():
	DialogueManagerGlobal.diagnostic_taken.connect(_on_diagnostic_chosen)
	_load_categories()
	diagnostic_taker.create(categories)

func _on_link_category_pressed(name: String):
	print(name)

func _load_categories():
	categories = []
	var paths = _get_all_files("res://resources/diagnostics/categories/", ".tres")
	for path in paths:
		categories.append(ResourceLoader.load(path) as DiagnosticType)

func _get_all_files(path: String, sufix: String):
	var dir = DirAccess.open(path)
	var paths = []
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if not dir.current_is_dir():
				if file_name.ends_with(sufix):
					paths.append(path + file_name)
			file_name = dir.get_next()
	return paths

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

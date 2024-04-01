extends CanvasLayer

signal take_diagnostic

@onready var panel_profile = %PatientMainPanel
@onready var panel_test = $TestMainPanel

var npc_data: NPCBase

func _ready():
	#var npc = ResourceLoader.load("res://resources/npc_data/default.tres") as NPCBase
	#initiate(npc)
	panel_profile.take_test.connect(_on_patient_take_test)
	panel_test.take_test.connect(_on_test_take)
	panel_test.cancel_test.connect(_on_test_take)
	panel_profile.take_diagnostic.connect(_on_take_diagnostic)

func initiate(npc: NPCBase):
	npc_data = npc
	panel_profile.initiate(npc_data)

func _on_patient_take_test():
	panel_profile.set_process_mode(4)
	panel_test.visible = true

func _on_test_take(test: Test = null):
	if test != null:
		pass
	
	panel_profile.set_process_mode(0)
	if test in npc_data.illness.tests.keys():
		panel_profile.test_taken(test, npc_data.illness.tests[test])
	else:
		panel_profile.test_taken(test, test.default_diagnostic)
	panel_test.visible = false

func _on_take_diagnostic():
	emit_signal("take_diagnostic")

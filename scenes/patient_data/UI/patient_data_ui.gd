extends CanvasLayer

signal take_diagnostic

@onready var panel_profile = %PatientMainPanel
@onready var panel_test = $TestMainPanel
@onready var panel_diagnostic = %DiagnosticMainPanel

var npc_data: NPCBase

func _ready():
	panel_profile.take_test.connect(_on_patient_take_test)
	panel_test.take_test.connect(_on_test_take)
	panel_test.cancel_test.connect(_on_test_take)
	panel_profile.take_diagnostic.connect(_on_patient_take_diagnostic)
	panel_profile.take_cure.connect(_on_take_cure)

	panel_diagnostic.take_diagnostic.connect(_on_diagnostic_take)
	panel_diagnostic.cancel_diagnostic.connect(_on_diagnostic_take)

func initiate(npc: NPCBase):
	npc_data = npc
	panel_profile.initiate(npc_data)

func _on_patient_take_test():
	panel_profile.set_process_mode(4)
	panel_test.visible = true

func _on_test_take(test: Test = null):
	panel_profile.set_process_mode(0)
	panel_test.visible = false

	if test != null:
		if test in npc_data.illness.tests.keys():
			panel_profile.test_taken(test, npc_data.illness.tests[test])
		else:
			panel_profile.test_taken(test, test.default_diagnostic)

func _on_patient_take_diagnostic():
	panel_profile.set_process_mode(4)
	panel_diagnostic.visible = true

func _on_diagnostic_take(diagnostic: Diagnostic = null):
	panel_profile.set_process_mode(0)
	panel_diagnostic.visible = false
	
	if diagnostic != null:
		panel_profile.diagnostic_taken(diagnostic.description == npc_data.illness)

func _on_take_cure():
	emit_signal("take_diagnostic")

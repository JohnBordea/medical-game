extends CanvasLayer

signal take_diagnostic
signal cancel

@onready var panel_profile = %PatientMainPanel
@onready var panel_test = $TestMainPanel
@onready var panel_diagnostic = %DiagnosticMainPanel

var npc_data: NPCBase

func _ready():
	panel_profile.take_test.connect(_on_patient_take_test)
	panel_profile.take_diagnostic.connect(_on_patient_take_diagnostic)
	panel_profile.take_cure.connect(_on_take_cure)
	panel_profile.cancel.connect(_on_cancel)

	panel_test.take_test.connect(_on_test_take)
	panel_test.cancel_test.connect(_on_test_take)

	panel_diagnostic.take_diagnostic.connect(_on_diagnostic_take)
	panel_diagnostic.cancel_diagnostic.connect(_on_diagnostic_take)

func initiate(npc: NPCBase):
	npc_data = npc
	panel_profile.initiate(npc_data)

func _on_patient_take_test():
	panel_profile.set_process_mode(4)
	panel_test.visible = true
	panel_test.initiate()

func _on_test_take(test: Test = null):
	panel_profile.set_process_mode(0)
	panel_test.visible = false
	DialogueManagerGlobal.reset_test_chosen()

	if test != null:
		if npc_data.illness.check_if_test_possible(test):
			Config.add_test_to_save(npc_data, test, npc_data.illness.get_test_result(test))
			panel_profile.test_taken(test, npc_data.illness.get_test_result(test))
		else:
			Config.add_test_to_save(npc_data, test, test.default_diagnostic)
			panel_profile.test_taken(test, test.default_diagnostic)

func _on_patient_take_diagnostic():
	panel_profile.set_process_mode(4)
	panel_diagnostic.visible = true
	panel_diagnostic.initiate()

func _on_diagnostic_take(diagnostic: IllnessBase = null):
	panel_profile.set_process_mode(0)
	panel_diagnostic.visible = false
	DialogueManagerGlobal.reset_diagnostic_chosen()
	
	if diagnostic != null:
		Config.add_diagnostic_to_save(npc_data, diagnostic == npc_data.illness)
		panel_profile.diagnostic_taken(diagnostic == npc_data.illness, diagnostic.combat_entity != null)

func _on_take_cure():
	emit_signal("take_diagnostic")

func _on_cancel():
	emit_signal("cancel")

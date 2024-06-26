extends PanelContainer

signal take_test
signal take_diagnostic
signal take_cure
signal cancel

@onready var panel_profile = %ProfilePanel
@onready var panel_profile_data = %ProfileDataPanel
@onready var panel_history = %HistoryPanel
@onready var panel_sympthoms = %SymptomPanel
@onready var panel_test = %TestPanel
@onready var panel_diagnostic = %DiagnosticPanel

func _ready():
	panel_test.take_test.connect(_on_patient_take_test)
	panel_diagnostic.diagnostic.connect(_on_patient_take_diagnostic)
	panel_diagnostic.cure.connect(_on_patient_take_cure)
	panel_diagnostic.cancel.connect(_on_cancel_procedure)

func initiate(npc: NPCBase):
	panel_profile.initiate(npc.sprite_body, npc.sprite_hair)
	panel_profile_data.initiate(npc.name, npc.gender, npc.age)
	panel_history.initiate(npc.illness.history)
	panel_sympthoms.initiate(npc.illness.symptoms)
	panel_test.initiate(npc)
	panel_diagnostic.initiate(npc)

func test_taken(test: Test, result: String, test_count: bool = false):
	panel_test.add_test_result(test, result)
	if test_count:
		panel_diagnostic.test_taken()

func diagnostic_taken(chosen_corectly: bool, can_be_cured: bool = true):
	panel_diagnostic.diagnostic_taken(chosen_corectly, can_be_cured)

func _on_patient_take_test():
	emit_signal("take_test")

func _on_patient_take_diagnostic():
	emit_signal("take_diagnostic")

func _on_patient_take_cure():
	emit_signal("take_cure")

func _on_cancel_procedure():
	emit_signal("cancel")

extends PanelContainer

signal take_test
signal take_diagnostic

@onready var panel_profile = %ProfilePanel
@onready var panel_profile_data = %ProfileDataPanel
@onready var panel_history = %HistoryPanel
@onready var panel_sympthoms = %SymptomPanel
@onready var panel_test = %TestPanel
@onready var panel_diagnostic = %DiagnosticPanel

func _ready():
	#var npc = ResourceLoader.load("res://resources/npc_data/default.tres") as NPCBase
	#initiate(npc)
	panel_test.take_test.connect(_on_patient_take_test)
	panel_diagnostic.diagnostic.connect(_on_patient_take_diagnostic)

func initiate(npc: NPCBase):
	panel_profile.initiate(npc.sprite)
	panel_profile_data.initiate(npc.name, npc.gender, npc.age)
	panel_history.initiate(npc.illness.history)
	panel_sympthoms.initiate(npc.illness.symptoms)
	panel_test.initiate()
	panel_diagnostic.initiate()

func test_taken(test: Test, result: String):
	panel_test.add_test_result(test.image, test.name, result)
	panel_diagnostic.test_taken()

func _on_patient_take_test():
	emit_signal("take_test")

func _on_patient_take_diagnostic():
	emit_signal("take_diagnostic")

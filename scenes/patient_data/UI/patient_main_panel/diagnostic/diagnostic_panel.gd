extends PanelContainer

signal diagnostic
signal cure
signal cancel

@onready var b_diagnostic = %Diagnose
@onready var b_cure = %Cure
@onready var result = %Result

func initiate(npc: NPCBase):
	result.text = ""
	b_diagnostic.disabled = true
	b_cure.disabled = true

	var npc_location = Config._get_npc_location(npc)
	if npc_location.diagnostic_made:
		diagnostic_taken(npc_location.diagnostic_made)
	elif npc_location.tests_taken.size() > 0:
		test_taken()

func test_taken():
	b_diagnostic.disabled = false

func diagnostic_taken(chosen_corectly: bool):
	if chosen_corectly:
		result.text = "Correct Diagnosys"
		b_diagnostic.disabled = true
		b_cure.disabled = false
	else:
		result.text = "Wrong Diagnosys"

func _on_diagnose_pressed():
	emit_signal("diagnostic")

func _on_cure_pressed():
	emit_signal("cure")

func _on_exit_pressed():
	emit_signal("cancel")

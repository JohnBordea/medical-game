extends PanelContainer

signal diagnostic
signal cure

@onready var b_diagnostic = %Diagnose
@onready var b_cure = %Cure
@onready var result = %Result

func initiate():
	b_diagnostic.disabled = true
	b_cure.disabled = true

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

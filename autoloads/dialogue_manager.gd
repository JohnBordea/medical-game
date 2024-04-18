extends Node

signal start
signal end
signal start_treatment_menu(npc: NPCBase)

var npc: NPCBase

func start_dialogue(npc: NPC):
	if npc.dialogue != null:
		self.npc = npc.data
		DialogueManager.show_example_dialogue_balloon(npc.dialogue, npc.dialogue_start)
		emit_signal('start')

func start_treatment():
	emit_signal('start_treatment_menu', npc)

func end_dialogue():
	emit_signal('end')

signal test_taken(test: Test)
var _test_taken_checker: Test = null

func test_chosen(test: Test):
	_test_taken_checker = test
	emit_signal("test_taken", test)

func check_test_if_is_pressed(test: Test):
	return _test_taken_checker == test

func reset_test_chosen():
	_test_taken_checker = null

signal diagnostic_taken(diagnostic: Diagnostic)
var _diagnostic_taken_checker: Diagnostic = null

func diagnostic_chosen(diagnostic: Diagnostic):
	emit_signal("diagnostic_taken", diagnostic)

func check_diagnostic_if_is_pressed(diagnostic: Diagnostic):
	return _diagnostic_taken_checker == diagnostic

func reset_diagnostic_chosen():
	_diagnostic_taken_checker = null

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

func test_chosen(test: Test):
	emit_signal("test_taken", test)

extends Resource
class_name QuestBase

@export_category("Info")
@export var title: String
@export var description: String
@export var progress: Array[QuestProgressBase]
var progress_set: bool = false
var solved: bool = false
@export_category("Dependencies")
@export var prerequesites: Array[QuestBase]
@export_category("Visual Detail")
@export_global_file("*.png") var image = "res://resources/quest_system/classes/quest_item_icon_default.png"
@export var coordinates: Vector2

func check(item: Resource):
	if not progress_set:
		progress_set = true
		for prog in progress:
			prog.check(item)

			if progress_set:
				progress_set = prog.progress_set

func is_unlocked() -> bool:
	for prerequesite in prerequesites:
		if not prerequesite.solved:
			return false
	return true

func solve_quest():
	if progress_set:
		solved = true

func print_debug():
	print(title)
	print(description)
	print()
	for prog in progress:
		print(prog.title)
		for action in prog.actions:
			print(action.character_class)
			print(action.item)
			print(action.amount)
			print(action._amount_completed)
	print()
	print()

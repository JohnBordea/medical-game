extends Resource
class_name QuestProgressAction

@export_enum("Use", "Cure") var character_class: String
@export var item: Resource
@export var amount: int = 1
var _amount_completed: int = 0
var progress_set: bool = false

func check(item: Resource):
	if self.item == item and not progress_set:
		_amount_completed += 1

	if _amount_completed >= amount:
		progress_set = true

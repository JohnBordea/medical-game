extends Resource
class_name QuestProgressBase

@export var title: String = "Generic Progress"
@export var actions: Array[QuestProgressAction]
var progress_set: bool = false

func check(item: Resource):
	if not progress_set:
		progress_set = true
		for action in actions:
			action.check(item)
			
			if progress_set:
				progress_set = action.progress_set

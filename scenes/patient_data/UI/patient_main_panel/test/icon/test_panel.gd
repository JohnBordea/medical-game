extends PanelContainer

@onready var icon = %TestIcon
@onready var title = %Title
@onready var result = %Result

func initiate(test_made: Test, test_result: String):
	icon.texture = load(test_made.image)
	title.text = test_made.name
	result.text = test_result

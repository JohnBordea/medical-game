extends PanelContainer

@onready var icon = %TestIcon
@onready var title = %Title
@onready var result = %Result

func initiate(image_path: String, test_title: String, test_result: String):
	icon.texture = load(image_path)
	title.text = test_title
	result.text = test_result

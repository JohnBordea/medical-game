extends PanelContainer

#@onready var profile = %ProfilePic
@onready var body = %Body
@onready var head = %Head

func initiate(body_path: String, head_path: String):
	body.texture = load(body_path)
	head.texture = load(head_path)

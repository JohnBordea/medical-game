extends PanelContainer

@onready var profile = %ProfilePic

func initiate(path: String):
	profile.texture = load(path)

extends TextureRect

@onready var pop_up_area = %PopUpArea

var data: Buff

func initiate(buff: Buff):
	data = buff
	texture = load(data.sprite)
	pop_up_area.title = buff.name

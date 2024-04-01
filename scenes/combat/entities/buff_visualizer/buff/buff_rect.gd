extends TextureRect

var data: Buff

func initiate(buff: Buff):
	data = buff
	texture = load(data.sprite)

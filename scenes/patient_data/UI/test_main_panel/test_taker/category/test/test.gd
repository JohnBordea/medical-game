extends MarginContainer

@onready var sprite = %Icon
@onready var title = %Name

var test: Test

func initiate(test: Test):
	self.test = test
	if test!= null:
		sprite.texture = load(self.test.image)
		title.text = self.test.name

func _on_button_pressed():
	DialogueManagerGlobal.test_chosen(test)

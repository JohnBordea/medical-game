extends PanelContainer

@onready var sprite = %Icon
@onready var title = %Name
@onready var chosen = %Chosen

var test: Test

func _process(delta):
	if DialogueManagerGlobal.check_test_if_is_pressed(test):
		chosen.visible = true
	else:
		chosen.visible = false

func initiate(test: Test):
	self.test = test
	if test!= null:
		sprite.texture = load(self.test.image)
		title.text = self.test.name

func _on_button_pressed():
	DialogueManagerGlobal.test_chosen(test)

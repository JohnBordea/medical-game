extends MarginContainer

@onready var sprite = %Icon
@onready var title = %Name

var diagnostic: Diagnostic

func initiate(diagnostic: Diagnostic):
	self.diagnostic = diagnostic
	if diagnostic!= null:
		sprite.texture = load(self.diagnostic.image)
		title.text = self.diagnostic.name

func _on_button_pressed():
	DialogueManagerGlobal.diagnostic_chosen(diagnostic)

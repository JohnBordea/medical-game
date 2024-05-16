extends PanelContainer

@onready var sprite = %Icon
@onready var title = %Name
@onready var chosen = %Chosen

var diagnostic: IllnessBase

func _process(delta):
	if DialogueManagerGlobal.check_diagnostic_if_is_pressed(diagnostic):
		chosen.visible = true
	else:
		chosen.visible = false

func initiate(diagnostic: IllnessBase):
	self.diagnostic = diagnostic
	if diagnostic!= null:
		sprite.texture = load(self.diagnostic.image)
		title.text = self.diagnostic.title

func _on_button_pressed():
	DialogueManagerGlobal.diagnostic_chosen(diagnostic)

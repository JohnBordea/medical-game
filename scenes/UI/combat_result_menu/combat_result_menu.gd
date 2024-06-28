extends CanvasLayer

signal proceed

@onready var encountered = %Encountered
@onready var winner = %Winner

func _input(event):
	if visible:
		if Input.is_action_just_released("interact"):
			emit_signal("proceed")

func initiate(encounter: IllnessBase, result: bool = false):
	encountered.text = encounter.title
	if result:
		winner.text = "Tratat cu Succes"
	else:
		winner.text = "Tratament Esuat"

func _on_proceed_pressed():
	emit_signal("proceed")

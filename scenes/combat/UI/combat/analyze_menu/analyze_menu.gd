extends CanvasLayer

signal back

@onready var data_name = %Name
@onready var data_unavailable = %DataUnavailable
@onready var data_box = %DataBox
@onready var data_description = %GeneralDescription
@onready var icon = %Icon

var data: CombatEntity

func _input(event):
	if Input.is_action_just_released("escape"):
		emit_signal("back")

func initiate(data: CombatEntity):
	self.data = data
	data_name.text = data.name
	data_description.text = data.description
	icon.texture = load(data.sprite)
	if Config.check_if_illness_is_known(data):
		data_unavailable.visible = false
		data_box.visible = true
	else:
		data_unavailable.visible = true
		data_box.visible = false

func _on_back_pressed():
	emit_signal("back")

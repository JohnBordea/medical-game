extends Button

signal was_pressed(type: SkillType)

var type: SkillType

func initiate(type: SkillType):
	self.type = type
	self.text = type.name

func _on_pressed():
	emit_signal("was_pressed", type)

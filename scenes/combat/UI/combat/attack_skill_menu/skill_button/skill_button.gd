extends Button

signal was_pressed(skill: SkillBase)

var skill: SkillBase

func initiate(skill: SkillBase):
	self.skill = skill
	text = self.skill.name
	if skill.active_cooldown > 0:
		disabled = true
		text = text + "(" + str(skill.active_cooldown) + ")"

func _on_pressed():
	emit_signal("was_pressed", skill)

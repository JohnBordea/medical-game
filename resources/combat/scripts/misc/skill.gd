extends Resource
class_name SkillBase

@export var name: String
@export var type: Config.SkillType
@export var power: float
@export var cooldown: int = 0
var active_cooldown: int = 0

@export var priority_factor: int = 0

@export var log_text: String = "used skill"

func activate_cooldown():
	active_cooldown = cooldown + 1

func decrease_cooldown(cooldown_mult_decr: int = 1):
	active_cooldown = max(active_cooldown - 1 * cooldown_mult_decr, 0)

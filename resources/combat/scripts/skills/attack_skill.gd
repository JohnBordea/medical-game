extends SkillBase
class_name SkillAttack

#What nullifies of target
@export var nullifies: Array[Buff]
#For priority list of player
@export var restriction: Array[Buff]
@export var add_buff: Array[Buff]
@export var true_damage: int = 0
#
#buff_bonus = {Buff: Buff <=> BuffFactor: float (x3)}
#
@export var buff_bonus: Dictionary
@export var buff_weakness: Dictionary

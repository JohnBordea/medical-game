extends Resource
class_name CombatEntity

@export var name: String
@export_global_file("*.png") var sprite
@export var is_player: bool
@export var ally: bool

@export var stats: StatBase
@export var skills: Array[SkillBase]

#Combat Stats
var hp_total: int
var hp_current: int
var buffs: Array[Buff] = []

var is_shield_on: bool = false
var shield_total: int
var shield_current: int

var debuffs: Array[Buff] = []
#how much damage to nullifie
var block_chance: float
var base_power: int

func initiate():
	hp_total = stats.constitution * 20
	hp_current = hp_total
	block_chance = .01 * (stats.strength + stats.constitution)
	base_power = stats.strength

func strategy() -> SkillBase:
	#TODO
	#implement a priority list for enemies moveset
	var priority: Array[SkillBase] = skills.duplicate()
	priority.sort_custom(
		func (a: SkillBase, b: SkillBase):
			return a.priority_factor > b.priority_factor
	)
	
	for move in priority:
		if move.active_cooldown == 0:
			return move
	return priority[-1]

func skill_damage(skill: SkillAttack) -> int:
	if skill in skills:
		var dmg_multiplier = 1.0
		for buff in buffs:
			if skill.buff_bonus.has(buff):
				dmg_multiplier = dmg_multiplier + skill.buff_bonus[buff]
		return base_power + skill.power * dmg_multiplier
	return 0

func add_shield(buff: ShieldBuff):
	#buffs.append(buff)
	if is_shield_on == true:
		shield_total += buff.shield
		shield_current += buff.shield
	else:
		is_shield_on = true
		shield_total = buff.shield
		shield_current = buff.shield

func damage(damage: int):
	if is_shield_on:
		shield_current = max(shield_current - damage, 0)
		if shield_current == 0:
			is_shield_on = false
	else:
		hp_current = max(hp_current - damage, 0)

func skill_cooldown_dec():
	for skill in skills:
		skill.decrease_cooldown()

func buff_cooldown_dec():
	for buff in buffs:
		if buff.cooldown > 0:
			buff.cooldown = max(buff.cooldown - 1, 0)

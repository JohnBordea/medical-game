extends Node2D
class_name EntityCombatVisual

@onready var animator = $AnimationPlayer
@onready var hp_bar = %HPBar
@onready var entity_name = %EntityName
@onready var damage_label = %DamageLabel
@onready var buff_visualizer = %BuffVisualizer
@onready var sprite = $Sprite2D

@export var data: CombatEntity

var target: CombatEntity = null

func _process(delta):
	if data.is_shield_on:
		hp_bar.set_bar(data.shield_total, data.shield_current, true)
	else:
		hp_bar.set_bar(data.hp_total, data.hp_current)

func initiate():
	data.initiate()
	entity_name.text = data.name
	if data.sprite != null:
		sprite.texture = load(data.sprite)
		var dimension = max(sprite.texture.get_size().x, sprite.texture.get_size().y)
		sprite.scale = Vector2(92 / dimension, 92 / dimension)

func attack_animation(attack_skill: SkillAttack):
	_add_buffs(attack_skill.add_buff)
	data.buff_cooldown_dec()
	animator.play("attack")

func _attack():
	CombatBase.player_attack(data)

var _damage: int
var _attack_move: SkillAttack
func attacked_animation(skill: SkillAttack, damage: int):
	var block_multiplier = 1.0 - data.block_chance
	for buff in data.buffs:
		block_multiplier = block_multiplier - buff.block_chance
	_damage = max(damage * block_multiplier, 0) + min(skill.true_damage, damage)

	if _damage > 0:
		damage_label.text = "-" + str(_damage)
	else:
		damage_label.text = "0"

	CombatBase.set_damage_of_attack(damage, _damage)

	#TODO
	#check if attack nullifies buffs or adds buffs
	for nullified in skill.nullifies:
		if nullified in data.buffs:
			_erase_buff(nullified)

	animator.play("damaged")

func _attacked():
	data.damage(_damage)
	CombatBase.target_attacked(data)

var added_buffs: Array[Buff]
func buff_animation(buff_skill: SkillBuff):
	added_buffs = buff_skill.adds
	animator.play("buff")

func _buffed():
	_add_buffs(added_buffs)

	for buff in data.buffs:
		if buff.cooldown == 0:
			_erase_buff(buff)

	CombatBase.player_buffed(data)

func _add_buffs(buffs: Array[Buff]):
	for added_buff in buffs:
		if added_buff is HealBuff:
			_heal_buff(added_buff)
		if added_buff is StatBuff:
			_add_buff(added_buff)
		if added_buff is ShieldBuff:
			_add_shield(added_buff)
	data.buff_cooldown_dec()

func _heal_buff(buff: Buff):
	data.hp_current = min(data.hp_current + buff.hp_heal, data.hp_total)
	#TODO
	#if to eliminate buffs

func _add_buff(buff: Buff):
	data.buffs.append(buff)
	buff_visualizer.add_buff(buff)

func _add_shield(buff: ShieldBuff):
	data.add_shield(buff)

func _erase_buff(buff: Buff):
	data.buffs.erase(buff)
	buff_visualizer.pop_buff(buff)

extends Node

signal playable_turn(player: CombatEntity, enemy: CombatEntity)
signal game_over(winner: CombatEntity)
signal move_made(log: String)

var player_list: Array[EntityCombatVisual]
var enemy_data: IllnessBase
var player_queue: Array[EntityCombatVisual]
var player: EntityCombatVisual
var target: EntityCombatVisual

var player_move: SkillBase
#Info for logger
var log: String = ""
var move_dmg: int = 0
var move_dmg_true: int = 0

func set_player_list(player_list: Array[EntityCombatVisual], enemy_data: IllnessBase):
	self.player_list = player_list
	self.enemy_data = enemy_data

func play_game():
	player_queue = player_list.duplicate()
	player_queue.sort_custom(
		func(a: EntityCombatVisual, b: EntityCombatVisual):
			return a.data.stats.agility > b.data.stats.agility
	)
	play_turn()

func play_turn():
	player = player_queue.pop_front()
	target = _get_target(player)
	if player.data.is_player:
		emit_signal("playable_turn", player.data, target.data)
	else:
		player_execute_move(player.data, player.data.strategy())

func _get_target(player: EntityCombatVisual) -> EntityCombatVisual:
	for p in player_queue:
		if p.data.is_player != player.data.is_player and p.data.hp_current > 0:
			return p
	return null

func player_execute_move(player: CombatEntity, skill: SkillBase):
	if self.player.data != player:
		return
	player_move = skill
	if player_move.type == Config.SkillType.PHYSICAL:
		player_move.activate_cooldown()
		self.player.attack_animation(player_move)
	if player_move.type == Config.SkillType.BUFF:
		player_move.activate_cooldown()
		self.player.buff_animation(player_move)

func player_attack(player: CombatEntity):
	if self.player.data != player:
		return
	target.attacked_animation(player_move, self.player.data.skill_damage(player_move))

func target_attacked(target: CombatEntity):
	if self.target.data != target:
		return
	end_turn()

func player_buffed(player: CombatEntity):
	if self.player.data != player:
		return
	end_turn()

func set_damage_of_attack(dmg: int, dmg_true: int):
	move_dmg = dmg
	move_dmg_true = dmg_true

func _send_logger_data():
	#construct log
	log = player.data.name + " " + player_move.log_text
	
	if player_move is SkillAttack:
		log = log + ", dealing " + str(move_dmg_true) + " (" + str(move_dmg) + ")"
		if not player_move.add_buff.is_empty():
			log = log + ", gaining "
			for buff in player_move.add_buff:
				log = log + " " + buff.name
	emit_signal("move_made", log)
	move_dmg = 0
	move_dmg_true = 0

func end_turn():
	_send_logger_data()
	player.data.skill_cooldown_dec()
	if _check_if_over():
		emit_signal("game_over", player.data)
	else:
		player_queue.append(player)
		play_turn()

func _check_if_over() -> bool:
	for player in player_queue:
		if player.data.hp_current > 0:
			return false
	return true

func analyse_enemy_is_known(enemy: IllnessBase) -> bool:
	return enemy in Config.local_save.illneses_encountered

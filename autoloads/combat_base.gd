extends Node

signal playable_turn(player: CombatEntity)
signal game_over(winner: CombatEntity)

var player_list: Array[EntityCombatVisual]
var player_queue: Array[EntityCombatVisual]
var player: EntityCombatVisual
var target: EntityCombatVisual

var player_move: SkillBase

func set_player_list(player_list: Array[EntityCombatVisual]):
	self.player_list = player_list

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
		emit_signal("playable_turn", player.data)
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

func end_turn():
	player.data.skill_cooldown_dec()
	if _check_if_over():
		print("Player[" + player.data.name + "] - won")
		emit_signal("game_over", player.data)
	else:
		player_queue.append(player)
		play_turn()

func _check_if_over() -> bool:
	for player in player_queue:
		if player.data.hp_current > 0:
			return false
	return true

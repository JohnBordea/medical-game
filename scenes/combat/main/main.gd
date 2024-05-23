extends Node2D

@onready var players_list = $Players
@onready var attack_manu = $AttackMenu

@onready var player = $Players/Player
@onready var enemy = $Players/Enemy

var enemy_data: IllnessBase

func initiate(enemy: IllnessBase):
	var list: Array[EntityCombatVisual] = []
	
	list.append(player)
	player.initiate()
	
	enemy_data = enemy
	self.enemy.data = enemy.combat_entity
	list.append(self.enemy)
	self.enemy.initiate()
	
	CombatBase.playable_turn.connect(_on_playable_turn)
	attack_manu.skill_chosen.connect(_on_playable_move)
	
	attack_manu.clear_logger()
	
	CombatBase.set_player_list(list, enemy)
	CombatBase.play_game()

func _on_playable_turn(player: CombatEntity, enemy: CombatEntity):
	attack_manu.visible = true
	attack_manu.initiate(player, enemy, enemy_data)

func _on_playable_move(player: CombatEntity, skill: SkillBase):
	attack_manu.visible = false
	CombatBase.player_execute_move(player, skill)

extends Node2D

@onready var players_list = $Players
@onready var attack_manu = $AttackMenu

@onready var player = $Players/Player
@onready var enemy = $Players/Enemy

var menu_user: CombatEntity

func initiate(enemy: CombatEntity):
	var list: Array[EntityCombatVisual] = []
	
	list.append(player)
	player.initiate()
	
	self.enemy.data = enemy
	list.append(self.enemy)
	self.enemy.initiate()
	
	CombatBase.playable_turn.connect(_on_playable_turn)
	attack_manu.skill_chosen.connect(_on_playable_move)
	
	#for entity in players_list.get_children():
	#	entity.initiate()
	#	list.append(entity)
	
	CombatBase.set_player_list(list)
	CombatBase.play_game()

func _on_playable_turn(player: CombatEntity):
	attack_manu.visible = true
	attack_manu.initiate(player)

func _on_playable_move(player: CombatEntity, skill: SkillBase):
	attack_manu.visible = false
	CombatBase.player_execute_move(player, skill)

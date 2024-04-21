extends Node

enum SkillType{
	PHYSICAL,
	BUFF
}

var skill_type_info = {
	#"physical": ResourceLoader.load("res://resources/combat/entities/skills/type/physical.tres"),
	#"buff": ResourceLoader.load("res://resources/combat/entities/skills/type/buff.tres")
}

var global_npc_locations: Array[NPCBase]

var global_quests: Array[QuestBase] = []

func _ready():
	load_quests()

func load_quests():
	global_quests.append(ResourceLoader.load("res://resources/quest_system/resources/quests/quest_1.tres") as QuestBase)
	global_quests.append(ResourceLoader.load("res://resources/quest_system/resources/quests/quest_2.tres") as QuestBase)

func quest_checker(item: Resource):
	for quest in global_quests:
		if quest.is_unlocked():
			quest.check(item)

func show_quests():
	for quest in global_quests:
		quest.print_debug()

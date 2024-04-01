extends Node

enum SkillType{
	PHYSICAL,
	BUFF
}

var skill_type_info = {
	#"physical": ResourceLoader.load("res://resources/combat/entities/skills/type/physical.tres"),
	#"buff": ResourceLoader.load("res://resources/combat/entities/skills/type/buff.tres")
}

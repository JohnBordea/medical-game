extends CanvasLayer

signal skill_chosen(player: CombatEntity, skill: SkillBase)

@onready var analyze_menu = %AnalyzeMenu
@onready var main_menu = %MainMenu
@onready var skill_type_menu = %SkillTypeMenu
@onready var attack_skill_menu = %AttackSkillMenu

var data: CombatEntity
var enemy: CombatEntity
var current_node: Node

func _ready():
	main_menu.attack.connect(_on_main_menu_action)
	main_menu.analyze.connect(_on_main_menu_analyze)
	analyze_menu.back.connect(_on_analyze_menu_back)
	skill_type_menu.type_chosen.connect(_on_skill_type_menu_type_chosen)
	skill_type_menu.back.connect(_on_skill_type_menu_back)
	attack_skill_menu.skill_chosen.connect(_on_skill_chosen)
	attack_skill_menu.back.connect(_on_attack_skill_menu_back)

func initiate(player: CombatEntity, enemy: CombatEntity):
	data = player
	self.enemy = enemy
	analyze_menu.initiate(enemy)
	#init type menu
	var paths = Config._get_all_files("res://resources/combat/obj/entities/player/skill_types/", ".tres")
	var types: Array[SkillType] = []
	for path in paths:
		var type = ResourceLoader.load(path) as SkillType
		types.append(type)
	skill_type_menu.initiate(types)
	_change_current_scene(main_menu)

func _on_main_menu_action():
	_change_current_scene(skill_type_menu)

func _on_main_menu_analyze():
	_change_current_scene(analyze_menu)

func _on_analyze_menu_back():
	_change_current_scene(main_menu)

func _on_skill_type_menu_type_chosen(type: SkillType):
	_change_current_scene(attack_skill_menu)
	var skills: Array[SkillBase] = []
	for s in data.skills:
		if s in type.skills:
			skills.append(s)
	attack_skill_menu.initiate(skills)

func _on_skill_type_menu_back():
	_change_current_scene(main_menu)

func _on_skill_chosen(skill: SkillBase):
	emit_signal("skill_chosen", data, skill)

func _on_attack_skill_menu_back():
	_change_current_scene(skill_type_menu)

func _change_current_scene(scene: Node):
	if scene:
		if current_node:
			current_node.visible = false
		current_node = scene
		current_node.visible = true

extends Resource
class_name IllnessBase

@export_global_file("*.png") var image = "res://resources/tests/default_icon.png"
@export var title: String
@export var description: String = "Simple information about the Illness. Maybe a few fun facts about it. ETC..."

@export var history: Array[HistoryBase]
@export var symptoms: Array[SymptomBase]
#needs to be Test: String
@export var tests: Dictionary
@export var combat_entity: CombatEntity

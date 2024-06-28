extends Resource
class_name IllnessBase

@export_global_file("*.png") var image = "res://resources/tests/default_icon.png"
@export var title: String
@export var description: String = "Simple information about the Illness. Maybe a few fun facts about it. ETC..."

@export var gender: float = .5
@export var age: Array[Array] = [[0, 90]]

@export var history: Array[HistoryBase]
@export var symptoms: Array[SymptomBase]
#needs to be Test: String
@export var tests: Array[TestResult]
@export var combat_entity: CombatEntity
@export var manifest: String
@export var counter: String

func check_if_test_possible(test: Test) -> bool:
	for t in tests:
		if t.test == test:
			return true
	return false

func get_test_result(test: Test) -> String:
	for t in tests:
		if t.test == test:
			return t.get_test_result()
	return ""

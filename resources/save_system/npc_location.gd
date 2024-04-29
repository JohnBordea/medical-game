extends Resource
class_name NPCLocation

@export var position: Vector2
@export var npc: NPCBase
@export var tests_taken: Array[Test]
@export var tests_taken_results: Array[String]
@export var diagnostic_made: bool = false

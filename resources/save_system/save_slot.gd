extends Resource
class_name SaveSlot

@export var name: String
@export var date: String

@export var map_path: String
@export var player_coord: Vector2

@export var quest_list: Array[QuestBase]
@export var maps_positioning: Array[MapPositioning]

@export var to_be_deleted: bool = false

@export_category("Combat Analisis Data")
@export var illneses_encountered: Array[IllnessBase]

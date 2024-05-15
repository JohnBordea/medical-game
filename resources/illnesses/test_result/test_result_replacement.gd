extends Resource
class_name TestResultReplacement

enum RequirenmentType {
	INT,
	STRING,
	FLOAT
}

@export var formater: String
@export var replacer_type: RequirenmentType
@export var replacer: Array

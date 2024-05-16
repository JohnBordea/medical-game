extends Resource
class_name TestResult

@export var test: Test
@export var result: String
var visual_result: String
@export var replacements: Array[TestResultReplacement]

func get_test_result() -> String:
	visual_result = result
	if replacements != null and !replacements.is_empty():
		for replacement in replacements:
			var value
			if replacement.replacer_type == 0:
				#INT type
				value = str(randi_range(replacement.replacer[0], replacement.replacer[1]))
			elif replacement.replacer_type == 1:
				#STRING
				value = replacement.replacer.pick_random()
			elif replacement.replacer_type == 2:
				#FLOAT
				value = str(randf_range(replacement.replacer[0], replacement.replacer[1])).pad_decimals(2)
			visual_result = visual_result.format({replacement.formater: value})
	return visual_result

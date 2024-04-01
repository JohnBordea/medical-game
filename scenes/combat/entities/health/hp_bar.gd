extends ProgressBar

@onready var label = $Label

func set_bar(max_value: int, value: int, is_shiled: bool = false):
	label.text = str(value) + "/" + str(max_value)
	if is_shiled:
		self.max_value  = max_value
		self.value = value
	else:
		self.max_value  = max_value
		self.value = value

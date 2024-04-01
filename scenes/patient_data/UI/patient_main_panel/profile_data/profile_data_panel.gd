extends PanelContainer

@onready var p_name = %Name
@onready var p_gender = %Gender
@onready var p_age = %Age

func initiate(name: String, gender: String, age: int):
	p_name.text = "Name: " + name
	p_gender.text = "Gender: " + gender
	p_age.text = "Age: " + str(age) + " years old"

extends Node2D

enum AccesoryType {
	PAPER,
	BOOK,
	VASE,
	NONE
}

@onready var paper = %Paper

@export var accesory_type: AccesoryType = AccesoryType.NONE

func _ready():
	match accesory_type:
		AccesoryType.PAPER:
			pass
		AccesoryType.BOOK:
			pass
		AccesoryType.VASE:
			pass

extends CharacterBody2D
class_name Entity

@onready var _animation_player = $AnimatedSprite2D

@export var max_speed: int = 400
@export var _player_state: String = "idle"
@export var _player_state_direction: String = "down"

var _direction: Vector2 = Vector2.ZERO

func _ready():
	_play_animation()

func ajust_direction(direction: Vector2):
	_direction = direction

func _play_animation():
	if _direction.x > 0:
		_player_state_direction = "right"
	elif _direction.x < 0:
		_player_state_direction = "left"
	elif _direction.y > 0:
		_player_state_direction = "down"
	elif _direction.y < 0:
		_player_state_direction = "up"
		
	_animation_player.play(_player_state + "_" + _player_state_direction)

extends Entity
class_name Player

@onready var _dialogue_controller = $DialogueController
@onready var _step_sound = $StepSound

var _input: bool = true
var sound_over = true

var _npc: NPC = null

func _ready():
	DialogueManagerGlobal.start.connect(_on_dialogue_start)
	DialogueManagerGlobal.end.connect(_on_dialogue_end)
	_play_animation()

func _physics_process(delta):
	if _input:
		_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		if _direction.x == 0 and _direction.y == 0:
			_player_state = 'idle'
		else:
			_player_state = "walk"
		
		velocity = _direction * max_speed
		if Input.is_action_just_pressed("interact") and _npc != null:
			DialogueManagerGlobal.start_dialogue(_npc)
	else:
		_player_state = 'idle'
	_play_animation()
	move_and_slide()

func _play_animation():
	if _direction.x > 0:
		_player_state_direction = "right"
	elif _direction.x < 0:
		_player_state_direction = "left"
	elif _direction.y > 0:
		_player_state_direction = "down"
	elif _direction.y < 0:
		_player_state_direction = "up"

	if _player_state == "walk":
		_dialogue_controller.rotation = atan2(velocity.y, velocity.x)
		if not _step_sound.playing:
			_step_sound.play()

	_animation_player.play(_player_state + "_" + _player_state_direction)

func _on_dialogue_start():
	_input = false

func _on_dialogue_end():
	_input = true

func _on_dialogue_controller_body_entered(body):
	if body is NPC:
		_npc = body as NPC

func _on_dialogue_controller_body_exited(body):
	if _npc == body:
		_npc = null

func _on_step_sound_finished():
	sound_over = true

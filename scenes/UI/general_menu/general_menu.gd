extends CanvasLayer

signal option_made(simbol: String)

@onready var option_menu = %OptionMenu
@onready var hover_area = %HoverArea
@onready var animation_player = $AnimationPlayer

var dimension = 110
var hovered: bool = false

func _ready():
	for child in option_menu.get_children():
		child.pressed.connect(_on_option_pressed)

func _input(event):
	if event is InputEventMouseMotion:
		if event.position.y < dimension and not hovered:
			animation_player.play("hover_over")
			hovered = true
		elif event.position.y > dimension and hovered:
			animation_player.play("hover_hide")
			hovered = false

func _on_option_pressed(simbol: String):
	emit_signal("option_made", simbol)

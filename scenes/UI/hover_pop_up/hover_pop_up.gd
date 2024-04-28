extends CanvasLayer

@onready var hover_pop_up = %HoverPopUp
@onready var title = %Title

func _ready():
	Config.show_pop_up.connect(_on_show_pop_up)
	Config.hide_pop_up.connect(_on_hide_pop_up)
	print(get_viewport().size)

func _process(delta):
	if hover_pop_up.visible:
		_set_hover_pop_up_pos()

func _set_hover_pop_up_pos():
	var pos = get_viewport().get_mouse_position() + Vector2.ONE * 20

	var offset = Vector2.ZERO
	if (pos.x + hover_pop_up.size.x + 20) > get_viewport().size.x:
		offset.x = -hover_pop_up.size.x

	if (pos.y + hover_pop_up.size.y + 20) > get_viewport().size.y:
		offset.y = -hover_pop_up.size.y

	hover_pop_up.position = pos + offset

func _on_show_pop_up(title: String):
	hover_pop_up.visible = true
	self.title.text = title

func _on_hide_pop_up(title: String):
	if self.title.text == title:
		hover_pop_up.visible = false

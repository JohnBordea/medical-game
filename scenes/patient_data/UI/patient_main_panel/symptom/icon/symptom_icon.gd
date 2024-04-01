extends PanelContainer

@onready var s_texture = %Texture
@onready var s_title = %Title

func initiate(sympthom: SymptomBase):
	s_texture.texture = load(sympthom.image)
	s_title.text = sympthom.name

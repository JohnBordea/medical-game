extends PanelContainer

@onready var h_texture = %Texture
@onready var h_title = %Title

func initiate(history: HistoryBase):
	h_texture.texture = load(history.image)
	h_title.text = history.name

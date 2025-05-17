extends Panel

@onready var itemVisuals : Sprite2D = $CenterContainer/itemDisplay

func update(item: InvItem):
	if !item:
		itemVisuals.visible = false
		
	else:
		itemVisuals.visible = true
		itemVisuals.texture = item.texture
		itemVisuals.z_index = 1000
		
		

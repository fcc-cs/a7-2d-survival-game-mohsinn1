extends Panel

@onready var itemVisuals : Sprite2D = $CenterContainer/Panel/itemDisplay
@onready var amountText: Label = $CenterContainer/Panel/Label


func update(slot: InvSlot):
	if !slot.item:
		itemVisuals.visible = false
		amountText.visible = false
		
	else:
		itemVisuals.visible = true
		itemVisuals.texture = slot.item.texture
		itemVisuals.z_index = 1000
		if slot.amount > 1:
			amountText.visible = true
		amountText.text = str(slot.amount)
		
		

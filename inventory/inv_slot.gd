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
		if slot.amount > 1:
			amountText.visible = true
			amountText.z_index = 1
		amountText.text = str(slot.amount)
		
		

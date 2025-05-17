extends Control
@onready var inv : Inv = preload("res://inventory/player_inventory.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()
var is_open = false



func _ready():
	updateSlots()
	close()
	
func open():
	visible = true
	is_open = true
	

func close():
	visible = false
	is_open = false
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("inventory"):
		if is_open:
			close()
		else:
			open()
			
func updateSlots():
	for i in range(min(slots.size(), inv.items.size())):
		slots[i].update(inv.items[i])
		

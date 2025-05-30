extends Resource


class_name Inv
signal update 
@export var slots: Array[InvSlot]

func insert(item: InvItem):
	var itemsSlots = slots.filter(func(slot): return slot.item == item)
	if !itemsSlots.is_empty():
		itemsSlots[0].amount +=1
	else:
		var emptySlots = slots.filter(func(slot): return slot.item == null)
		if !emptySlots.is_empty():
			emptySlots[0].item = item
			emptySlots[0].amount = 1
	update.emit()

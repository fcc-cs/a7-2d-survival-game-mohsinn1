extends Control

signal quest_menu_closed

var quest1_active  = false
var quest1_completed = false
var stick = 0


func _process(delta: float) -> void:
	if quest1_active:
		if stick == 3 :
			print("Completed!!")
			quest1_active = false
			quest1_completed = true
	


func quest1_chat():
	$questUI.visible = true
	

func _on_yes_button_pressed() -> void:
	$questUI.visible = false
	quest1_active = true
	stick = 0
	emit_signal("quest_menu_closed")

func _on_no_button_pressed() -> void:
	$questUI.visible = false
	quest1_active = false
	emit_signal("quest_menu_closed")
	
func next_quest():
	if !quest1_completed:
		quest1_chat()
	else:
		$noQuest.visible = true
		await get_tree().create_timer(3).timeout
		$noQuest.visible = false


func stickCollected():
	stick +=1 
	print(stick)
	

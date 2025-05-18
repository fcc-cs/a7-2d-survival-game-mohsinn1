extends Control

@export_file("*.json") var d_file
signal d_finished
var dialogue = []
var current_dia_id = 0
var is_active = false


func _ready():
	$NinePatchRect.visible = false
	
	
func start():
	if is_active:
		return
	is_active = true
	$NinePatchRect.visible = true
	dialogue = loadDialogue()
	current_dia_id = -1
	nextScript()

func loadDialogue():
	var file = FileAccess.open("res://worker_dialogue1.json",FileAccess.READ)
	var content = JSON.parse_string(file.get_as_text())
	return content
	
func _input(event):
	if !is_active:
		return
	if event.is_action_pressed("ui_page_down"):
		nextScript()
	
func nextScript():
	current_dia_id += 1
	if current_dia_id >= len(dialogue):
		is_active = false
		$NinePatchRect.visible = false
		emit_signal("d_finished")
		return
		
		
	
	$NinePatchRect/Name.text = dialogue[current_dia_id]["name"]
	$NinePatchRect/Text.text = dialogue[current_dia_id]["text"]
	

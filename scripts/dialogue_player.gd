extends Control

@export_file("*.json") var d_file

var dialogue = []
var cuurent_dia_id = 0

func _ready():
	start()
	
	
func start():
	dialogue = loadDialogue()

func loadDialogue():
	var file = FileAccess.open("res://worker_dialogue1.json",FileAccess.READ)
	var content = JSON.parse_string(file.get_as_text())
	return content
	

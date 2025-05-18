extends Node2D
@onready var animPlayer = $world2openingcutscene/AnimationPlayer
var is_opening_cutscene = false
@onready var camera = $Path2D/PathFollow2D/Camera2D
var has_entered = false
var is_pathfollowing = false
var player = null


func _physics_process(delta: float) -> void:
	if is_opening_cutscene:
		var pathfollower = $Path2D/PathFollow2D
		
		if is_pathfollowing:
			pathfollower.progress_ratio += 0.001
			if pathfollower.progress_ratio >= 1:
				cutsceneclosing()
				

func _on_player_detection_body_entered(body: Node2D) -> void:
	if body.has_method("Player"):
		player = body
	
		if !has_entered:
			has_entered = true
			cutsceneopening()


func cutsceneopening():
	is_opening_cutscene = true
	animPlayer.play("fade")
	player.camera.enabled = false
	camera.enabled = true
	is_pathfollowing = true
	
func cutsceneclosing():
	is_pathfollowing = false
	is_opening_cutscene = false
	camera.enabled = false
	player.camera.enabled = true
	$world2openingcutscene.visible = false
	$world2main.visibilty = true
	

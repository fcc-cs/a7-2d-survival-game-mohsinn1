extends Node2D
@onready var animPlayer = $world2openingcutscene/AnimationPlayer
var is_opening_cutscene = false
@onready var camera = $world2openingcutscene/Path2D/PathFollow2D/Camera2D
var has_entered = false
var is_pathfollowing = false
var player = null
var smoke_has_happened = false
var smoke_is_happening = false


func _physics_process(delta: float) -> void:
	if is_opening_cutscene:
		var pathfollower = $world2openingcutscene/Path2D/PathFollow2D
		
		if is_pathfollowing:
			if !smoke_is_happening:
				pathfollower.progress_ratio += 0.001
			if pathfollower.progress_ratio >= 1:
				cutsceneclosing()
			if !smoke_has_happened and pathfollower.progress_ratio >= 0.87 and !smoke_is_happening:
				smoke_is_happening = true
				toggle_smoke()
				await get_tree().create_timer(1).timeout
				$world2openingcutscene/TileMapFinished.visible = true
				$world2openingcutscene/TileMapUnfinished.visible = NOTIFICATION_LOCAL_TRANSFORM_CHANGED
				
				await get_tree().create_timer(0.5).timeout
				smoke_has_happened = true
				smoke_is_happening = false
				
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
	$world2main.visible = true
	
func toggle_smoke():
	var smoke1 = $world2openingcutscene/SmokeParticles1
	var smoke2 = $world2openingcutscene/SmokeParticles2
	var smoke3 = $world2openingcutscene/SmokeParticles3
	var smoke4 = $world2openingcutscene/SmokeParticles4
	smoke1.emitting = !smoke1.emitting
	smoke2.emitting = !smoke2.emitting
	smoke3.emitting = !smoke3.emitting
	smoke4.emitting = !smoke4.emitting
	
	

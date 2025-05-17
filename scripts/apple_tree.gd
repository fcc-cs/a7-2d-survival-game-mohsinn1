extends Node2D
var state = "no apples"
var playerInArea = false
@onready var timer = $growthTimer
@onready var tree = $AnimatedSprite2D
var apple = preload("res://scenes/apple_collectable.tscn")


func _ready() -> void:
	if state == "no apples":
		timer.start()

func _process(delta: float) -> void:
	if state == "no apples":
		tree.play("no apples")
		
	if state == "apples":
		tree.play("apples")
		
	if playerInArea:
		if Input.is_action_just_pressed("pickup"):
			state = "no apples"
			dropApple()
			print("apple picked")
			




func _on_pick_area_body_entered(body: Node2D) -> void:
	if body.has_method("Player"):
		playerInArea = true


func _on_pick_area_body_exited(body: Node2D) -> void:
	if body.has_method("Player"):
		playerInArea = false


func _on_growth_timer_timeout() -> void:
	if state == "no apples":
		state = "apples"

func dropApple():
	var appleInstance = apple.instantiate()
	appleInstance.global_position = $Marker2D.global_position
	get_parent().add_child(appleInstance)
	await get_tree().create_timer(3.0).timeout
	
	timer.start()
	

extends Node2D
var state = "no apples"
var playerInArea = false
@onready var timer = $growthTimer
@onready var tree = $AnimatedSprite2D

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
			timer.start()
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

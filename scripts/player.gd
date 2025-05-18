extends CharacterBody2D

var speed = 100
var playerState
@export var inv: Inv
var bowEquipped = false
var bowCooldown = true
var arrow = preload("res://scenes/arrow.tscn")
@onready var player = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	if direction.x == 0 and direction.y == 0:
		playerState = "idle"
	elif direction.x != 0 or direction.y != 0:
		playerState = "walking"
	
		
	velocity = direction * speed
	move_and_slide()
	
	if Input.is_action_just_pressed("equip"):
		if bowEquipped:
			bowEquipped = false
		else:
			bowEquipped = true
	
	var mousePosition = get_global_mouse_position()
	$Marker2D.look_at(mousePosition)
	if Input.is_action_just_pressed("left mouse") and bowEquipped and bowCooldown:
		bowCooldown = false
		var arrowInstance = arrow.instantiate()
		arrowInstance.rotation = $Marker2D.rotation
		arrowInstance.global_position = $Marker2D.global_position
		add_child(arrowInstance)
		await get_tree().create_timer(0.5).timeout
		bowCooldown = true	
	playAnim(direction)
	
func playAnim(dir):
	if playerState == "idle":
		player.play("idle")
		
	if playerState == "walking":
		
		if dir.y == -1:
			player.play("northWalk")
			
		if dir.y == 1:
			player.play("southWalk")
			
		if dir.x == 1:
			player.play("eastWalk")
			
		if dir.x == -1:
			player.play("westWalk")
			
		if dir.x > 0.5 and dir.y < -0.5:
			player.play("northEWalk")
		
		if dir.x > 0.5 and dir.y > 0.5:
			player.play("southEWalk")
			
		if dir.x < -0.5 and dir.y < -0.5:
			player.play("northWWalk")
			
		if dir.x < -0.5 and dir.y > 0.5:
			player.play("southWWalk")
			
			
func Player():
	pass

func collect(item):
	inv.insert(item)
	

			
		

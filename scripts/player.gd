extends CharacterBody2D

var speed = 100
var playerState
@onready var player = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	if direction.x == 0 and direction.y == 0:
		playerState = "idle"
	elif direction.x != 0 or direction.y != 0:
		playerState = "walking"
		
	velocity = direction * speed
	move_and_slide()
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
		
			
		

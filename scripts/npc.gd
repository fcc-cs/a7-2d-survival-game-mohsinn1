extends CharacterBody2D
const speed = 30
var current_state = IDLE
var isRoaming = true
var isChatting = false
var dir = Vector2.RIGHT
var startPos
var player
var playerInChatZone = false
@onready var npc = $AnimatedSprite2D

enum{
	IDLE,
	NEW_DIR,
	MOVE
}


func _ready():
	randomize()
	startPos = position
	
func _process(delta: float) -> void:
	if current_state == 0 or current_state == 1:
		npc.play("idle")
	
	elif current_state == 2 and !isChatting:
			if dir.y == -1:
				npc.play("walk_n")
				
			if dir.y == 1:
				npc.play("walk_s")
				
			if dir.x == 1:
				npc.play("walk_e")
				
			if dir.x == -1:
				npc.play("walk_w")
	
	if isRoaming:
		match current_state:
			IDLE:
				pass
			NEW_DIR:
				dir = choose([Vector2.RIGHT,Vector2.LEFT,Vector2.UP,Vector2.DOWN])
			
			MOVE:
				move(delta)
	if Input.is_action_just_pressed("chat"):
		print("chatting")
		isRoaming = false
		isChatting = true
		npc.play("idle")

func choose(array):
	array.shuffle()
	return array.front()

func move(delta):
	if !isChatting:
		position += dir * speed * delta
				
				

	

func _on_chat_detection_area_body_entered(body: Node2D) -> void:
	if body.has_method("Player"):
		player = body
		playerInChatZone = true


func _on_chat_detection_area_body_exited(body: Node2D) -> void:
	if body.has_method("Player"):
		playerInChatZone = false


func _on_timer_timeout() -> void:
	$Timer.wait_time = choose([0.5, 1 , 1.5])
	current_state = choose([IDLE, NEW_DIR, MOVE])

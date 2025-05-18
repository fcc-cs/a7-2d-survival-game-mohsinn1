extends CharacterBody2D

var speed = 50
var health = 100
var damage

var dead = false
var player_in_area = false
var player
@onready var slime = $slime_collectable
@export var itemRes: InvItem

func _ready() -> void:
	dead = false
	
func _physics_process(delta: float) -> void:
	if !dead:
		$detection_area/CollisionShape2D.disabled = false
		if player_in_area:
			position += (player.position-position)/speed
			$AnimatedSprite2D.play("move")
		else:
			$AnimatedSprite2D.play("idle")
		if dead:
			$detection_area/CollisionShape2D.disabled = true
			

func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.has_method("Player"):
		player = body
		player_in_area = true

func _on_detection_area_body_exited(body: Node2D) -> void:
	if body.has_method("Player"):
		player_in_area = false


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.has_method("arrow_damage"):
		damage = 50
		take_damage(damage)

func take_damage(damage):
	health -= damage
	if health <= 0:
		death()

func death():
	dead = true
	$AnimatedSprite2D.play("death")
	await get_tree().create_timer(1).timeout
	dropSlime()
	$AnimatedSprite2D.visible = false
	$hitbox/CollisionShape2D.disabled = true
	$detection_area/CollisionShape2D.disabled = true

func dropSlime():
	slime.visible = true
	$collectArea/CollisionShape2D.disabled = false
	slimeCollect()

func slimeCollect():
	await get_tree().create_timer(1.5).timeout
	slime.visible = false
	player.collect(itemRes)
	queue_free()
	


func _on_collect_area_body_entered(body: Node2D) -> void:
	if body.has_method("Player"):
		player = body

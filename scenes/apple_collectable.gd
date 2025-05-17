extends StaticBody2D
@onready var applePlayer = $AnimationPlayer

func _ready() -> void:
	fallFromTree()
	
func fallFromTree():
	applePlayer.play("fallingFromTree")
	await get_tree().create_timer(1).timeout
	applePlayer.play("fade")
	queue_free()
	

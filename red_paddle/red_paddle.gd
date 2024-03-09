extends CharacterBody2D
@export var MOVEMENT_SPEED: float = 400.0


func _physics_process(delta):
	player_movement(MOVEMENT_SPEED)
	move_and_slide()

func player_movement(speed: float) -> void:
	if Input.is_action_pressed("move_up_alternate"):
		velocity.y = -speed
		# print("up")
	elif Input.is_action_pressed("move_down_alternate"):
		velocity.y = speed
		# print("down")
	else:
		velocity.y = 0

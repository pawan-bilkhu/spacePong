extends StaticBody2D
@export var MOVEMENT_SPEED: float = 400.0


func _physics_process(delta):
	player_movement(MOVEMENT_SPEED*delta)

func player_movement(speed: float) -> void:
	if Input.is_action_pressed("move_up"):
		set_constant_linear_velocity(Vector2(0, -1)*speed)
		# print("up")
	elif Input.is_action_pressed("move_down"):
		set_constant_linear_velocity(Vector2(0, 1)*speed)
		# print("down")
	else:
		set_constant_linear_velocity(Vector2(0, 0))

extends StaticBody2D
@export var MOVEMENT_SPEED: float = 400.0
const screen_minimum_threshold = 0
const screen_maximum_threshold = 648

func _physics_process(delta):
	player_movement(MOVEMENT_SPEED*delta)

func player_movement(speed: float) -> void:
	if global_position.y >= screen_minimum_threshold:
		if Input.is_action_pressed("move_up"):
			position.y -= speed
		# print("up")
	if global_position.y <= screen_maximum_threshold: 	
		if Input.is_action_pressed("move_down"):
			position.y += speed
		# print("down")
	

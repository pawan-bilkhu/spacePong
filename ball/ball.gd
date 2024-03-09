extends CharacterBody2D

@export var speed: float = 400.0

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity.y = randf_range(200, speed) * float((-1)**randi()%2)
	velocity.x = randf_range(200, speed) * float((-1)**randi()%2)
	SignalManager.on_goal_scored.connect(destroy_ball)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Testing purposesw
	#if not is_on_floor():
		#velocity.y += gravity * delta
	var collision = move_and_collide(velocity*delta)
	
	if not collision:
		return
	velocity = velocity.bounce(collision.get_normal())
	

func destroy_ball() -> void:
	queue_free()
	

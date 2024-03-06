extends RigidBody2D

var impulse_force = Vector2.ONE

func _ready():
	impulse_force.x *= randf_range(200, 400)
	impulse_force.y *= randf_range(200, 400)
	if randf()*5 < 3:
		impulse_force.y*-1
	if randf()*10 > 3:
		impulse_force.x*-1
	apply_impulse(impulse_force)

func _physics_process(delta):
	var collision = move_and_collide(get_linear_velocity()*delta)
	if collision:
		apply_impulse(collision.get_normal()*get_linear_velocity())


func _on_body_entered(body):
	print(body.group())

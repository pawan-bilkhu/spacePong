extends Node2D

@onready var ball_spawn = $SpriteNodes/BallSpawn
@onready var blue_spawn = $SpriteNodes/BlueSpawn
@onready var red_spawn = $SpriteNodes/RedSpawn
@onready var timer = $Timer
@onready var red_paddle_score = $HUD/GameHUD/RedPaddleScore
@onready var blue_paddle_score = $HUD/GameHUD/BluePaddleScore
@onready var game_over = $HUD/GameOverHUD/GameOver
@onready var countdown = $HUD/GameHUD/Countdown
@onready var particles: CPUParticles2D = $Particles

var has_game_ended: bool = false
@export var particle_speed_scale: float = 0 

# Called when the node enters the scene tree for the first time.
func _ready():
	has_game_ended = false
	particles_emit()
	SignalManager.ball_bounce.connect(increase_emission_speed.bind(0.125))
	SignalManager.on_goal_scored.connect(display_score)
	SignalManager.on_goal_scored.connect(start_countdown)
	SignalManager.on_goal_scored.connect(particles_emit)
	SignalManager.on_game_over.connect(on_game_over)
	GameManager.create_ball(blue_spawn.position, GameManager.OBJECT_KEY.BLUE_PADDLE)
	GameManager.create_ball(red_spawn.position, GameManager.OBJECT_KEY.RED_PADDLE)
	GameManager.set_maximum_score(5)
	red_paddle_score.text = "00"
	blue_paddle_score.text = "00"
	countdown.show()
	countdown.text = "0"
	game_over.hide()
	start_countdown()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	countdown.text = "%1.00f " % timer.time_left


func _on_timer_timeout():
	GameManager.create_ball(ball_spawn.position, GameManager.OBJECT_KEY.BALL)
	countdown.hide()


func display_score() -> void:
	red_paddle_score.text = "%02d" % GameManager.get_score(GameManager.PADDLES.RED)
	blue_paddle_score.text = "%02d" % GameManager.get_score(GameManager.PADDLES.BLUE)


func _on_goal_left_body_entered(body):
	if has_game_ended:
		return
	if body.is_in_group(GameManager.GROUP_BALL):
		print("Red scores")
		GameManager.increment_score(GameManager.PADDLES.RED, 1)
		SignalManager.on_goal_scored.emit()


func _on_goal_right_body_entered(body):
	if has_game_ended:
		return
	if body.is_in_group(GameManager.GROUP_BALL):
		print("Blue scores")
		GameManager.increment_score(GameManager.PADDLES.BLUE, 1)
		SignalManager.on_goal_scored.emit()


func particles_emit()->void:
	particles.emitting = true
	particles.speed_scale = 1


func start_countdown() -> void:
	if has_game_ended:
		return
	countdown.show()
	timer.start(3)


func on_game_over() -> void:
	has_game_ended = true
	game_over.text = "%s wins!" % GameManager.get_winner()
	game_over.show()


func increase_emission_speed(speed_scale: float)-> void:
	particles.speed_scale += speed_scale

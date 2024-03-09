extends Node2D

@onready var ball_spawn = $BallSpawn
@onready var timer = $Timer
@onready var red_paddle_score = $HUD/CanvasLayer/RedPaddleScore
@onready var blue_paddle_score = $HUD/CanvasLayer/BluePaddleScore
@onready var countdown = $HUD/CanvasLayer/Countdown

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_goal_scored.connect(display_score)
	SignalManager.on_goal_scored.connect(start_countdown)
	red_paddle_score.text = "0"
	blue_paddle_score.text = "0"
	countdown.show()
	countdown.text = "0"
	start_countdown()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	countdown.text = "%1.00f " % timer.time_left


func _on_timer_timeout():
	GameManager.create_ball(ball_spawn.position, GameManager.OBJECT_KEY.BALL)
	countdown.hide()

func display_score() -> void:
	red_paddle_score.text = str(GameManager.get_score(GameManager.PADDLES.RED))
	blue_paddle_score.text = str(GameManager.get_score(GameManager.PADDLES.BLUE))


func _on_goal_left_body_entered(body):
	if body.is_in_group(GameManager.GROUP_BALL):
		print("Red scores")
		GameManager.increment_score(GameManager.PADDLES.RED, 1)
		SignalManager.on_goal_scored.emit()


func _on_goal_right_body_entered(body):
	if body.is_in_group(GameManager.GROUP_BALL):
		print("Blue scores")
		GameManager.increment_score(GameManager.PADDLES.BLUE, 1)
		SignalManager.on_goal_scored.emit()
		
func start_countdown() -> void:
	countdown.show()
	timer.start(3)

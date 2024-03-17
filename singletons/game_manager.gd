extends Node

const GROUP_BALL: String = "ball"
var maximum_score: int = 0
enum OBJECT_KEY {
	BALL,
	BLUE_PADDLE,
	RED_PADDLE
	}

const SIMPLE_SCENE = {
	OBJECT_KEY.BALL : preload("res://ball/ball.tscn"),
	OBJECT_KEY.BLUE_PADDLE : preload("res://blue_paddle/blue_paddle_static.tscn"),
	OBJECT_KEY.RED_PADDLE : preload("res://red_paddle/red_paddle_static.tscn"),
}

enum PADDLES {
	BLUE,
	RED
}

var POINTS: Dictionary = {
	PADDLES.BLUE : 0,
	PADDLES.RED : 0
}

var winner = ""



func set_score(key: PADDLES, value: int) -> void:
	POINTS[key] = value
	print(value)
	
func get_score(key: PADDLES) -> int:
	return POINTS[key]
	
func increment_score(key: PADDLES, value: int) -> void:
	set_score(key, POINTS[key]+value)
	if POINTS[key] >= maximum_score:
		set_winner(key)
		SignalManager.on_game_over.emit()

func set_winner(key: PADDLES) -> void:
	if key == PADDLES.BLUE:
		winner= "Blue"
	else:
		winner= "Red"

func get_winner() -> String:
	return winner

func set_maximum_score(value: int) -> void:
	maximum_score = value
	
func get_maximum_score() -> int:
	return maximum_score

func add_child_deferred(child_to_add) -> void:
	get_tree().root.add_child(child_to_add)

func call_add_child(child_to_add) -> void:
	call_deferred("add_child_deferred", child_to_add)

func create_ball(start_position: Vector2, key: OBJECT_KEY) -> void:
	var new_ball = SIMPLE_SCENE[key].instantiate()
	new_ball.global_position = start_position
	call_add_child(new_ball)

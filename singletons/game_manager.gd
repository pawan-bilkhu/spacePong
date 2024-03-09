extends Node

const GROUP_BALL: String = "ball"
enum OBJECT_KEY {BALL}

const SIMPLE_SCENE = {
	OBJECT_KEY.BALL : preload("res://ball/ball.tscn")
}

enum PADDLES {
	BLUE,
	RED
}

var POINTS: Dictionary = {
	PADDLES.BLUE : 0,
	PADDLES.RED : 0
}

func set_score(key: PADDLES, value: int) -> void:
	POINTS[key] = value
	print(value)
	
func get_score(key: PADDLES) -> int:
	return POINTS[key]
	
func increment_score(key: PADDLES, value: int) -> void:
	set_score(key, POINTS[key]+value)

func add_child_deferred(child_to_add) -> void:
	get_tree().root.add_child(child_to_add)

func call_add_child(child_to_add) -> void:
	call_deferred("add_child_deferred", child_to_add)

func create_ball(start_position: Vector2, key: OBJECT_KEY) -> void:
	var new_ball = SIMPLE_SCENE[key].instantiate()
	new_ball.global_position = start_position
	call_add_child(new_ball)

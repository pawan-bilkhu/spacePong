extends Area2D


func _on_body_entered(body):
	if body.is_in_group(GameManager.GROUP_BALL):
		GameManager.increment_score(GameManager.PADDLES.RED, 1)


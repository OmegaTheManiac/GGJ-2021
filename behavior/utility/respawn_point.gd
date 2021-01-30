extends Position2D

func _on_Area2D_body_entered(body: Node) -> void:
	if body is Player:
		var player := body as Player
		player.respawn_point = position

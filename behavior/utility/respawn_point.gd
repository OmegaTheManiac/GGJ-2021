extends Position2D

export var is_start_point : bool = false

func _ready() -> void:
	$Sprite.frame = 1
	
	if is_start_point:
		if GameStateManager.is_new_level:
			set_respawn()
			GameStateManager.gen()

func _on_Area2D_body_entered(body: Node) -> void:
	if body is Player:
		set_respawn()

func set_respawn() -> void:
	GameStateManager.respawn_position = position
	$Sprite.frame = 0

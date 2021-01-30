extends Collidable

class_name Player

var respawn_point : Vector2

func _respawn() -> void:
	get_tree().reload_current_scene()

func _destroy() -> void:
	_respawn()

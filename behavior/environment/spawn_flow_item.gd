extends Collidable

class_name SpawnFlowItem

func _on_Area_body_exited(body : Node) -> void:
	if body == self:
		queue_free()

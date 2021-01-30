extends Collidable

class_name Enemy

var _chase_point : Player
export var speed : float = 10
export var acceleration : float = 0.5
export var alert_group : bool = false

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	if _chase_point:
		var direction : Vector2 = (_chase_point.global_position - global_position).normalized()
		var force : Vector2 = applied_force.linear_interpolate(direction * speed, acceleration)
		apply_central_impulse(force)

func _on_ChaseArea_body_entered(body: Node) -> void:
	if body is Player:
		_chase_point = body
		if alert_group and len(get_groups()) > 0:
			var group : String = get_groups()[0]
			get_tree().call_group(group, "set_chase_point", _chase_point)
			
func set_chase_point(val : Node) -> void :
	_chase_point = val

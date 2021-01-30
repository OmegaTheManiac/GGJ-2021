extends Area2D

class_name FlowSegment
onready var line : Line2D = $Line2D
onready var collision_line : CollisionShape2D = $CollisionShape2D

var _start : Vector2 
var _end : Vector2
var _direction : float
var _length : float

export var width : float = 20
var speed_max : float = 20
export var speed_scale : float = 1.25

func instantiate(start : Vector2, end : Vector2, parent : Node) -> void:
	self._start = start
	self._end = end
	self._length = _start.distance_to(_end)
	self._direction = (_end	- _start).angle()
	gravity_vec = (_end - _start).clamped(speed_max) * speed_scale
	#priority = gravity_vec.length()
	parent.add_child(self)	
	
func _ready() -> void:
	# draw line
	line.width = width
	line.clear_points()
	line.add_point(_start)
	line.add_point(_end)
	
	var collision_shape :=  CapsuleShape2D.new()
	collision_shape.height = _length
	collision_shape.radius = width/2.0
	collision_line.shape = collision_shape
	
	collision_line.rotation = _direction + (PI/2)
	collision_line.translate(_start)

func _physics_process(delta: float) -> void:
	line.default_color.a = $Timer.time_left
	
	if $Timer.time_left == 0:
		queue_free()

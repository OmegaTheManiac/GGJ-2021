extends Node2D

onready var backdrop = get_parent()
const flow_segment_scene : PackedScene = preload("res://scene/player/FlowSegment.tscn")
var current_flow : Line2D

var _previous_point : Vector2 = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("draw"):
		var new_flow = flow_segment_scene.instance()
		new_flow.instantiate(_previous_point, get_global_mouse_position(),
		get_tree().get_root())

	_previous_point = get_global_mouse_position()

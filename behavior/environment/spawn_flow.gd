extends Node2D

export var spawn_flow_item_scene : PackedScene
onready var _area = $Area2D
var _top : Vector2
var _width : float
var _rnd := RandomNumberGenerator.new()

export var gravity : Vector2
export var spawn_rate : float
var _time_since_last_spawn : float = 0.0

func _ready() -> void:
	_top = global_position + ($Area2D/CollisionShape2D.shape.extents.y * Vector2.UP)
	_width = $Area2D/CollisionShape2D.shape.extents.x 
	_area.gravity_vec = gravity

func _process(delta: float) -> void:
	if _time_since_last_spawn > spawn_rate:
		_time_since_last_spawn = 0
		create_spawn_flow_item()
		
	_time_since_last_spawn += delta

func create_spawn_flow_item() -> void:
	var new_spawn_flow_item : SpawnFlowItem = spawn_flow_item_scene.instance()
	add_child(new_spawn_flow_item)
	new_spawn_flow_item.global_position = rand_vector_range()
	_area.connect("body_exited", new_spawn_flow_item, "_on_Area_body_exited")
		
		
func rand_vector_range() -> Vector2:
	var out_vec = _top
	out_vec.x += _rnd.randf_range(0, _width * 2) - _width
	return out_vec

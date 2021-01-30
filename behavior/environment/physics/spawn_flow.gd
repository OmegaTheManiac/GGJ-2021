extends Node2D

export var spawning : bool = false
export var spawn_flow_item_scene : PackedScene
onready var _area = $Area2D
onready var _spawn_zone_start : Vector2 = $SpawnZoneStart.global_position
onready var _spawn_zone_end : Vector2 = $SpawnZoneEnd.global_position
var _rnd := RandomNumberGenerator.new()

export var gravity : Vector2
export var spawn_rate : float
var _time_since_last_spawn : float = 0.0

func _ready() -> void:
	_area.gravity_vec = gravity

func _process(delta: float) -> void:
	if spawning:
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
	var out_vec = _spawn_zone_start.linear_interpolate(_spawn_zone_end, _rnd.randf())
	return out_vec

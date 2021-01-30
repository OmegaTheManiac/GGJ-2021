extends Node2D

const _player_scene : PackedScene = preload("res://scene/player/Player.tscn")
var respawn_position : Vector2
var is_new_level : bool = true

func regen() -> void:
	get_tree().reload_current_scene()
	gen()


func gen() -> void:
	var player : Player = _player_scene.instance()
	get_tree().root.call_deferred("add_child",player)
	player.position = respawn_position
	is_new_level = false

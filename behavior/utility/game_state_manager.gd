extends Node2D

const _player_scene : PackedScene = preload("res://scene/player/Player.tscn")

func _ready() -> void:
	pass

func regen() -> void:
	get_tree().reload_current_scene()


func _gen() -> void:
	var player : Player = _player_scene.instance()
	

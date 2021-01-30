extends Light2D

export var speed : float = 1
export var texture_start_scale = 1
export var texture_end_scale = 1.2
onready var tween : Tween = $Tween
var _tween_endpoints : Array

func _ready() -> void:
	tween.connect("tween_completed", self, "_on_Tween_completed")
	tween.interpolate_property(self, "texture_scale", texture_start_scale, texture_end_scale, speed, Tween.TRANS_SINE, Tween.EASE_IN_OUT, 0)
	tween.start()
	
	_tween_endpoints = [texture_start_scale, texture_end_scale]

func _on_Tween_completed(object, key) -> void:
	_tween_endpoints.invert()
	tween.interpolate_property(self, "texture_scale", _tween_endpoints[0], _tween_endpoints[1], speed, Tween.TRANS_SINE, Tween.EASE_IN_OUT, 0)
	tween.start()

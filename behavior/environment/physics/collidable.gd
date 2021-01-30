extends RigidBody2D

class_name Collidable

export var health : int = 3
export var _min_damage_velocity : float = 100
var _gravity : float
var _recovering : bool = false
var _recovery_period : float = 1.5
var _time_since_damage : float = 0

func _process(delta: float) -> void:
	if _recovering:
		_time_since_damage += delta
		
		if _time_since_damage > _recovery_period:
			_recovering = false
			$Sprite.self_modulate = Color.white

	if health <= 0:
		_destroy()

	
	
func _physics_process(_delta: float) -> void:
	_control_particle_emitter()
	
	# check for collision
	_check_collisions()
	
	$Sprite.rotation = linear_velocity.angle()


func _control_particle_emitter() -> void:
	if linear_velocity.length() > 10:
		$CPUParticles2D.emitting = true
		$CPUParticles2D.gravity = linear_velocity.rotated(PI)
	else:
		$CPUParticles2D.emitting = false


func _take_damage() -> void:
	health -= 1
	_recovering = true
	_time_since_damage = 0
	$Sprite.self_modulate = Color.red

func _destroy() -> void:
	queue_free()

func _check_collisions() -> void:
	if len(get_colliding_bodies()) > 0:
		# check if in recovery period
		if not _recovering:
			var body = get_colliding_bodies()[0]
			# take no damage if colliding with player
			#if not body.get_groups().has("player"):
				# check if speed is greater than own
			var collision_velocity : float
			var other_velocity: Vector2
			
			if body is TileMap:
				other_velocity = Vector2.ZERO
			else:
				other_velocity = body.linear_velocity
			
			if body is TileMap:
				collision_velocity = linear_velocity.length()
			else:
				collision_velocity = (linear_velocity - body.linear_velocity).length()
				
			if collision_velocity > _min_damage_velocity:
				_take_damage()

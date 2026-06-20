class_name Player extends Node3D

var planet_orbiting: Planet
var radius = 5.0
var speed = 1.0
var angle = 0.0
var current_speed : int = 5
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_move(delta)


func _move(delta) -> void:
	"""the point of this is to fly around the planets and jetison off to other places"""
	angle += speed * delta

	var x = cos(angle) * radius
	var z = sin(angle) * radius
	
	if planet_orbiting == null:
		return
	global_transform.origin = planet_orbiting.global_transform.origin + Vector3(x, 0, z)

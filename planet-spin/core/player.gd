class_name Player extends Node3D

#TODO have an accel and decel function
#work out what angle its hitting the orbit
#correct for speed
var planet_orbiting: Planet
var radius = 2.0
var speed = 1.0
var angle = 0.0
var current_speed : int = 5
#used by directions
var correction_speed : float = 0.1

#this is to handle what kind of movement to do
var leaving_orbit : bool = false
var in_orbit : bool = true
var firing_rockets : bool = false
#this is to correct course
var left_rockets : bool = false
var right_rockets : bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gameVars.player = self


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_move(delta)


func _move(delta) -> void:
	"""the point of this is to fly around the planets and jetison off to other places"""
	
	if in_orbit == true and firing_rockets == false:
		look_at(planet_orbiting.global_position, Vector3.UP)
		rotate(Vector3.UP, deg_to_rad(90))
		pass
		angle += speed * delta

		var x = cos(angle) * radius
		var z = sin(angle) * radius
		
		if planet_orbiting == null:
			return
		global_transform.origin = planet_orbiting.global_transform.origin + Vector3(x, 0, z)
		look_at(planet_orbiting.global_position, Vector3.UP)
		rotate(Vector3.UP, deg_to_rad(90))
	
	else:
		
		global_position += -global_transform.basis.z * speed * delta
		if left_rockets == true:
			self.rotate_y(+correction_speed)
		if right_rockets == true:
			self.rotate_y(-correction_speed)


func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.get_parent() is Planet:
		in_orbit = true
		planet_orbiting = area.get_parent()


func _on_area_3d_area_exited(area: Area3D) -> void:
	if area.get_parent() is Planet:
		#set the leaving orbit to false when it leave an orbit to allow the ship 
		#to attach to a new orbit
		leaving_orbit = false

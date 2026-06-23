class_name Player extends Node3D

#TODO have an accel and decel function
#work out what angle its hitting the orbit
#correct for speed
var planet_orbiting: Planet
var radius = 2.0
var angle = 0.0
var current_speed : int = 5
#used by directions
var correction_speed : float = 0.01
var fuel_reduction : int = 1

#this is to handle what kind of movement to do
var leaving_orbit : bool = false
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
	
	if left_rockets == true:
		self.rotate_y(+correction_speed)
	if right_rockets == true:
		self.rotate_y(-correction_speed)

	if self.get_parent() is Pivot and firing_rockets == false:
		return
	
	global_position += -global_transform.basis.z * (gameVars.player_speed+gameVars.speed_boost) * delta
	


func _on_fuel_tick_timeout() -> void:
	print(self.position)
	if firing_rockets == true or left_rockets == true or right_rockets == true:
		gameVars.fuel -= fuel_reduction
	else:
		return

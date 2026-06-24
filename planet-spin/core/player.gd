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
var cargo : Array = []
var MAX_CARGO : int = 20

#this is to handle what kind of movement to do
var leaving_orbit : bool = false
var firing_rockets : bool = false
#this is to correct course
var left_rockets : bool = false
var right_rockets : bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gameVars.player = self
	#set up cargo
	for c in range(MAX_CARGO):
		cargo.append(gameVars.PLANETS.None)


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
	if firing_rockets == true or left_rockets == true or right_rockets == true:
		gameVars.fuel -= fuel_reduction
	else:
		return


func add_cargo(destination : int, in_list : int):
	"""called in packages"""
	cargo[in_list] = destination
	print(cargo)
	
	
func drop_cargo(destination : int):
	"""called when landing on a planet, drop off stuff, then re order cargo"""
	var list_to_be_ordered : Array = []
	for c in cargo:
		if c == destination:
			#add cash or some shit
			c = gameVars.PLANETS.None

		else:
			if c > gameVars.PLANETS.None:
				list_to_be_ordered.append(c)
				
	
	if len(list_to_be_ordered) == 0:
		return
	
	for c in range(0, len(list_to_be_ordered)-1):
		cargo[c] = list_to_be_ordered[c]
	
	while len(cargo)-1 < MAX_CARGO:
		cargo.append(gameVars.PLANETS.None)
	
	print(cargo)

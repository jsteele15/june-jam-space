class_name Planet extends Node3D

@export var planet_name : int
@onready var pivot : Pivot = $pivot
@onready var col_box : CollisionShape3D = $Area3D/CollisionShape3D
@onready var drop_off_ring : Sprite3D = $"drop off ring"
@onready var packages : PackageCollection = $packages
@onready var start_pack : Timer = $"start packages"

@onready var player_orbiting : bool = false

var planet_mesh : MeshInstance3D

enum PLANET_SIZES {
	None = -1,
	SMALL,
	MEDIUM,
	LARGE,
	SUN
}
var planet_size : int 

func _ready() -> void:
	
	match planet_name:
		gameVars.PLANETS.SUN:
			planet_size = PLANET_SIZES.SUN
			
		gameVars.PLANETS.MERCURY:
			planet_size = PLANET_SIZES.SMALL
			
		gameVars.PLANETS.VENUS:
			planet_size = PLANET_SIZES.MEDIUM

		gameVars.PLANETS.EARTH:
			planet_size = PLANET_SIZES.MEDIUM
			
		gameVars.PLANETS.MOON:
			planet_size = PLANET_SIZES.SMALL
		
		gameVars.PLANETS.MARS:
			planet_size = PLANET_SIZES.MEDIUM
			
		gameVars.PLANETS.JUPITER:
			planet_size = PLANET_SIZES.LARGE
			
		gameVars.PLANETS.SATURN:
			planet_size = PLANET_SIZES.LARGE
			
		gameVars.PLANETS.URANUS:
			planet_size = PLANET_SIZES.MEDIUM
			
		gameVars.PLANETS.NEPTUNE:
			planet_size = PLANET_SIZES.MEDIUM
			
		gameVars.PLANETS.PLUTO:
			planet_size = PLANET_SIZES.SMALL
	
	_decide_sizes()
	
	drop_off_ring.modulate = gameVars.planet_colours[self.planet_name]
	$Sprite3D.modulate = gameVars.planet_colours[self.planet_name]
	
	await get_tree().process_frame
	for c in self.get_children():
		if c is MeshInstance3D:
			planet_mesh = c

func _process(delta: float) -> void:
	if gameVars.player.firing_rockets == true:
		if gameVars.player.get_parent() != Space:
			col_box.disabled = false
			_change_player_parent(false)
			drop_off_ring.visible = true
			 
			
	if player_orbiting:
		orbit_player()
		
	planet_mesh.rotate_y(0.001)

func _mission_arrived():
	"""called when player get to the right planet, right now itll just give you a new mission randomly"""
	gameVars.current_mission = randi_range(0, gameVars.PLANETS.Max-1)

func _decide_sizes():
	"""function called in the ready to decide how large the areas should be"""
	match planet_size:
		PLANET_SIZES.SMALL:
			col_box.shape = load("res://res/collision shapes/small_col.tres")
			drop_off_ring.scale = Vector3(0.48, 0.48, 0.48)
		PLANET_SIZES.MEDIUM:
			col_box.shape = load("res://res/collision shapes/medium_col.tres")
			drop_off_ring.scale = Vector3(0.8, 0.8, 0.8)
		PLANET_SIZES.LARGE:
			col_box.shape = load("res://res/collision shapes/large col.tres")
		PLANET_SIZES.SUN:
			col_box.shape = load("res://res/collision shapes/large col.tres")

func _change_player_parent(entering : bool):
	"""called in area detection"""
	player_orbiting = entering
	col_box.disabled = entering
	if entering == true:
		gameVars.player.reparent(pivot)
	else:
		gameVars.player.reparent(self.get_parent().get_parent())


func get_yaw_side(player: Node3D, target: Node3D) -> float:
	var to_target = (target.global_position - player.global_position).normalized()
	var forward = -player.global_transform.basis.z

	# Signed angle around Y axis
	return rad_to_deg(atan2(
		forward.cross(to_target).y,
		forward.dot(to_target)
	))


func _on_area_3d_area_entered(area: Area3D) -> void:
	print("entered %d", planet_name)
	if area.get_parent() is Player:
		print("entered %d", planet_name)
		if gameVars.player.firing_rockets == true:
			return
		if gameVars.current_mission == self.planet_name:
			_mission_arrived()
		pivot.pivot_dir(get_yaw_side(gameVars.player, self))
		_change_player_parent(true)
		col_box.disabled = true
		drop_off_ring.visible = false
		gameVars.player.drop_cargo(self.planet_name)
		packages.pick_up_package(gameVars.player)
		
		
func orbit_player() ->void:
	packages.pick_up_package(gameVars.player)

func _on_start_packages_timeout() -> void:
	packages.set_new_package()


func _on_area_3d_area_exited(area: Area3D) -> void:
	if area.get_parent() is Player:
		print("exited %d", planet_name)
		
func scale_planet_UI(scale: float) -> void:
	$Sprite3D.scale = Vector3(scale, scale, scale)
	$Sprite3D.position.x = (-$Sprite3D.texture.get_width()/100)*scale -1
	for i : Sprite3D in packages.get_children(true):
		i.scale = Vector3(scale, scale, scale)

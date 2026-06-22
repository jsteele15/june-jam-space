class_name Planet extends Node3D


@export var planet_mesh : MeshInstance3D
@export var planets_sun : Planet
@export var planet_name : int
@onready var pivot : Pivot = $pivot

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


func _decide_sizes():
	"""function called in the ready to decide how large the areas should be"""
	match planet_size:
		PLANET_SIZES.SMALL:
			pass
		PLANET_SIZES.MEDIUM:
			pass
		PLANET_SIZES.LARGE:
			pass
		PLANET_SIZES.SUN:
			pass

func _change_player_parent(entering : bool):
	"""called in area detection"""
	if entering == true:
		gameVars.player.reparent(pivot)
	else:
		gameVars.player.reparent(self.get_parent().get_parent())


func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.get_parent() is Player:
		_change_player_parent(true)


func _on_area_3d_area_exited(area: Area3D) -> void:
	if area.get_parent() is Player:
		_change_player_parent(false)

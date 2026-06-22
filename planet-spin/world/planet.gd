class_name Planet extends Node3D


@export var planet_mesh : MeshInstance3D
@export var planets_sun : Planet
@export var planet_name : int


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

extends Node

enum PLANETS {
	None = -1,
	SUN,
	MERCURY,
	VENUS,
	EARTH,
	MOON,
}


var planet_stats : Dictionary = {
	#radius, speed
	PLANETS.SUN : [10, 2],
	PLANETS.MERCURY : [10, 1.5],
	PLANETS.VENUS : [14, 1.0],
	PLANETS.EARTH : [18, 1.0],
	PLANETS.MOON : [2, 1.0]
}


var fuel: int = 100
var player_speed : int = 100

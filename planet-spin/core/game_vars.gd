extends Node

enum PLANETS {
	None = -1,
	SUN,
	MERCURY,
	VENUS,
	EARTH,
	MOON,
	MARS,
	JUPITER,
	SATURN,
	URANUS,
	NEPTUNE,
	PLUTO,
	Max
}

var planet_mission_text : Dictionary = {
	PLANETS.SUN : "Sun",
	PLANETS.MERCURY : "Mercury",
	PLANETS.VENUS : "Venus",
	PLANETS.EARTH : "Earth",
	PLANETS.MOON : "Moon",
	PLANETS.MARS : "Mars",
	PLANETS.JUPITER : "Jupiter",
	PLANETS.SATURN : "Saturn",
	PLANETS.URANUS : "Uranus",
	PLANETS.NEPTUNE : "Neptune",
	PLANETS.PLUTO : "Pluto"
}

var planet_colours : Dictionary = {
	PLANETS.SUN : Color(0.96, 0.559, 0.0, 1.0),
	PLANETS.MERCURY : Color(0.563, 0.723, 0.907, 1.0),
	PLANETS.VENUS : Color(0.997, 0.162, 0.642, 1.0),
	PLANETS.EARTH : Color(0.402, 0.771, 0.392, 1.0),
	PLANETS.MOON : Color(0.712, 0.725, 0.711, 1.0),
	PLANETS.MARS : Color(0.819, 0.258, 0.097, 1.0),
	PLANETS.JUPITER : Color(0.0, 0.801, 0.422, 1.0),
	PLANETS.SATURN : Color(0.771, 0.551, 1.0, 1.0),
	PLANETS.URANUS : Color(0.0, 0.754, 0.851, 1.0),
	PLANETS.NEPTUNE : Color(0.082, 0.344, 0.624, 1.0),
	PLANETS.PLUTO : Color(0.785, 0.665, 0.0, 1.0)
}

#just used for the planets animation, has no relation to player speed
var planet_spin_speed : float

#
#  vars for the player
#
#
#current mission will be a planet you have to get to
var current_mission : int = 0
#ive put the player ref here so im free to move it around different pivots without ref errors
#its declared when the player loads
var player : Player
#TODO decide if this should be money you have before going bancrupt
#that way you have to decide between getting fuel or getting time
var time_left : int = 100
var fuel: int = 100
var player_speed : float = 5.0
#used when pressing the rocket boost
var speed_boost : float = 0.0
var current_cash : int = 0
var MAX_SPEED : float = 8.0

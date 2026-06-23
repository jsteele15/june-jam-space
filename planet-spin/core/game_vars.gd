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
var player_speed : float = 1.0
#used when pressing the rocket boost
var speed_boost : float = 0.0
var MAX_SPEED : float = 8.0

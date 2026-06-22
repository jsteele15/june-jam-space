class_name Planet extends Node3D


@export var planet_mesh : MeshInstance3D
@export var planets_sun : Planet
@export var planet_name : int
@export var planet_texture : CompressedTexture2D

func _ready() -> void:
	
	match planet_name:
		gameVars.PLANETS.SUN:
			pass
		gameVars.PLANETS.MERCURY:
			pass
		gameVars.PLANETS.VENUS:
			pass
		gameVars.PLANETS.EARTH:
			pass
		gameVars.PLANETS.MOON:
			pass

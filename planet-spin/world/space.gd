class_name Space extends Node3D


@onready var planet_layer : Node = $planets
@onready var sound_board : SoundBoard = $sound_board
@onready var camera : Camera = $Camera3D
@onready var player : Player = $Player

func _ready() -> void:
	next_level()
	for planet : Planet in planet_layer.get_children():
		if planet.planet_name == gameVars.PLANETS.EARTH:
			planet.start_pack.start()
			break 

func _input(event: InputEvent) -> void:
	#
	#	All the inputs for the game, 
	#	launch is space; you have to hold launch to leave planets atmosphere
	#	left and right are left and right, but will only work when not in atmosphere
	#
	if event.is_action_pressed("launch"):
		gameVars.player.firing_rockets = true
		sound_board.fire_rockets()
		
	if event.is_action_released("launch"):
		gameVars.player.firing_rockets = false
		gameVars.speed_boost = 0.0
		
	if event.is_action_pressed("rocketleft"):
		gameVars.player.left_rockets = true
		sound_board.fire_rockets()
		
	if event.is_action_released("rocketleft"):
		gameVars.player.left_rockets = false
		
	if event.is_action_pressed("rocketright"):
		gameVars.player.right_rockets = true
		sound_board.fire_rockets()
		
	if event.is_action_released("rocketright"):
		gameVars.player.right_rockets = false
	
	if event.is_action_pressed("enter"):
		print(camera.zoom_level)
		next_level()
		print(camera.zoom_level)
		
		
func next_level() -> void:
	var next_planet = gameVars.new_planets.pop_front()
	if next_planet == null:
		return
	camera.zoom_level += 1
	
	gameVars.planet_options.append(next_planet)
	for planet : Planet in planet_layer.get_children():
		planet.packages.planet_options = gameVars.planet_options
		if planet.planet_name == next_planet:
			planet.start_pack.start()
		
		var UI_scale: float = camera.zoom_sizes[camera.zoom_level]/camera.zoom_sizes[1]
		planet.scale_planet_UI(UI_scale)
	
	

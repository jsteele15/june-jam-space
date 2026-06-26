class_name Space extends Node3D


@onready var planet_layer : Node = $planets
@onready var sound_board : SoundBoard = $sound_board
@onready var camera : Camera = $Camera3D
@onready var player : Player = $Player
var cur_level : int = 1
func _ready() -> void:
	next_level()


func _input(event: InputEvent) -> void:
	#
	#	All the inputs for the game, 
	#	launch is space; you have to hold launch to leave planets atmosphere
	#	left and right are left and right, but will only work when not in atmosphere
	#
	if gameVars.game_started == false:
		return
		
	if event.is_action_pressed("launch"):
		gameVars.player.firing_rockets = true
		gameVars.player.rocket_fire_left.emitting = true
		gameVars.player.rocket_fire_right.emitting = true
		sound_board.fire_rockets()
		#(-0.798689, 0.000687, -2.984277) this was the players pos we roughly wanna stop to do a tutorial

	if event.is_action_released("launch"):
		gameVars.player.firing_rockets = false
		gameVars.player.rocket_fire_left.emitting = false
		gameVars.player.rocket_fire_right.emitting = false
		gameVars.speed_boost = 0.0
		
	if event.is_action_pressed("rocketleft"):
		gameVars.player.left_rockets = true
		gameVars.player.rocket_fire_left.emitting = true
		sound_board.fire_rockets()
		
	if event.is_action_released("rocketleft"):
		gameVars.player.left_rockets = false
		gameVars.player.rocket_fire_left.emitting = false
		
	if event.is_action_pressed("rocketright"):
		gameVars.player.right_rockets = true
		gameVars.player.rocket_fire_right.emitting = true
		sound_board.fire_rockets()
		
	if event.is_action_released("rocketright"):
		gameVars.player.rocket_fire_right.emitting = false
		gameVars.player.right_rockets = false
	
	if event.is_action_pressed("enter"):
		print(camera.zoom_level)
		next_level()
		print(camera.zoom_level)
	
	if event.is_action_pressed("esc"):
		get_tree().quit()
	
		
func next_level() -> void:
	var new_planets
	
	if cur_level == 1:
		new_planets = [gameVars.PLANETS.MOON, gameVars.PLANETS.VENUS, gameVars.PLANETS.MARS, gameVars.PLANETS.EARTH]
	
	if cur_level == 2:
		new_planets = [gameVars.PLANETS.SUN, gameVars.PLANETS.MERCURY, gameVars.PLANETS.JUPITER]
	
	for p in range(new_planets.size()):
		gameVars.planet_options.append(new_planets[p])
	
	camera.zoom_level += 1
	
	
	for planet : Planet in planet_layer.get_children():
		planet.packages.planet_options = gameVars.planet_options
		
		var UI_scale: float = camera.zoom_sizes[camera.zoom_level]/camera.zoom_sizes[1]
		if cur_level == 2:
			planet.scale_planet_UI(UI_scale)
	cur_level += 1
	


func _on_package_timer_timeout() -> void:
	if gameVars.game_started == false:
		return
	var planets_active = []
	for planet : Planet in planet_layer.get_children():
		if planet.planet_name in gameVars.planet_options:
			planets_active.append(planet)
	
	var rand_plan = planets_active.pick_random()
	rand_plan.packages.set_new_package()


func _on_level_timer_timeout() -> void:
	if gameVars.game_started == false:
		return
	next_level()

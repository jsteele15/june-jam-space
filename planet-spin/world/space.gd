class_name Space extends Node3D

#TODO must do
#finish the loop
#add rest of sounds

#TODO nice to have
#credirs
#meteors
#game feel
#more story
#clean up code
#change speed
#change font
#change month timer
#popups
#reset speed
#check where player is

@onready var planet_layer : Node = $planets
@onready var sound_board : SoundBoard = $sound_board
@onready var camera : Camera = $Camera3D
@onready var player : Player = $Player
@onready var user_inter : ui = $ui
var cur_level : int = 1
var start_trig : bool = false
func _ready() -> void:
	next_level()
	$"rocket fire".emitting = true

func _process(delta: float) -> void:
	if gameVars.game_started == true and start_trig == false:
		$"timers/month timer".start()
		user_inter.story_box.show_story_box(Story.STORY_BEAT.OPENING_TEXT)
		$"rocket fire".emitting = false
		start_trig = true
		return


func _input(event: InputEvent) -> void:
	#
	#	All the inputs for the game, 
	#	launch is space; you have to hold launch to leave planets atmosphere
	#	left and right are left and right, but will only work when not in atmosphere
	#
	if gameVars.game_started == false:
		return
		
	if event.is_action_pressed("launch"):
		if gameVars.fuel <= 0:
			if gameVars.player.get_parent() != self:
				user_inter.story_box.current_story = Story.STORY_BEAT.OUT_OF_FUEL
				user_inter.story_box.show_story_box(Story.STORY_BEAT.OUT_OF_FUEL)
			print("no fuel")
			return
		gameVars.player.firing_rockets = true
		gameVars.player.rocket_fire_left.emitting = true
		gameVars.player.rocket_fire_right.emitting = true
		Story.player_stop = false
		sound_board.fire_rockets()
		#(-0.798689, 0.000687, -2.984277) this was the players pos we roughly wanna stop to do a tutorial

	if event.is_action_released("launch"):
		gameVars.player.firing_rockets = false
		gameVars.player.rocket_fire_left.emitting = false
		gameVars.player.rocket_fire_right.emitting = false
		gameVars.speed_boost = 0.0
		
	if event.is_action_pressed("rocketleft"):
		if gameVars.fuel <= 0:
			if gameVars.player.get_parent() != self:
				print("no fuel and orbiting")
			print("no fuel")
			return
		gameVars.player.left_rockets = true
		gameVars.player.rocket_fire_left.emitting = true
		sound_board.fire_rockets()
		
	if event.is_action_released("rocketleft"):
		gameVars.player.left_rockets = false
		gameVars.player.rocket_fire_left.emitting = false
		
	if event.is_action_pressed("rocketright"):
		if gameVars.fuel <= 0:
			if gameVars.player.get_parent() != self:
				print("no fuel and orbiting")
			print("no fuel")
			return
		gameVars.player.right_rockets = true
		gameVars.player.rocket_fire_right.emitting = true
		sound_board.fire_rockets()
		
	if event.is_action_released("rocketright"):
		gameVars.player.rocket_fire_right.emitting = false
		gameVars.player.right_rockets = false


	if event.is_action_pressed("esc"):
		get_tree().quit()


func reset_orbit_speeds():
	for p :Planet in planet_layer.get_children():
		p.pivot.amount_given = 0.0


func reset_player_on_screen():
	"""called in camera"""
	gameVars.player.position = Vector3(-5.672, 0.0, 3.257)
	user_inter.story_box.show_story_box(Story.STORY_BEAT.OFFSCREEN)
	gameVars.player_speed = 1.0
	sound_board.reset_player()
	reset_orbit_speeds()


func is_player_off_screen(player: Player, camera: Camera) -> bool:
	var pos = player.global_transform.origin

	# 1. Behind camera = definitely off screen
	if camera.is_position_behind(pos):
		return true

	# 2. Convert world → screen
	var screen_pos : Vector2 = camera.unproject_position(pos)
	var viewport_size = get_viewport().get_visible_rect().size

	# 3. Check if outside screen bounds
	if screen_pos.x < 0 or screen_pos.x > viewport_size.x:
		return true
	if screen_pos.y < 0 or screen_pos.y > viewport_size.y:
		return true

	return false

func next_level() -> void:
	var new_planets
	
	if cur_level == 1:
		new_planets = [gameVars.PLANETS.MOON, gameVars.PLANETS.VENUS, gameVars.PLANETS.MARS, gameVars.PLANETS.EARTH]
	
	if cur_level == 2:
		new_planets = [gameVars.PLANETS.SUN, gameVars.PLANETS.MERCURY, gameVars.PLANETS.JUPITER]
		user_inter.story_box.show_story_box(Story.STORY_BEAT.ROUTE)
		reset_orbit_speeds()
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


func _on_month_timer_timeout() -> void:
	if gameVars.months_left > 1:
		gameVars.months_left -= 1
	else:
		if gameVars.current_cash >= 0:
			user_inter.story_box.current_story = Story.STORY_BEAT.STORY_END_SUCCESS
			user_inter.story_box.show_story_box(user_inter.story_box.current_story)
			$"timers/month timer".stop()
		else:
			user_inter.story_box.current_story = Story.STORY_BEAT.STORY_END_FAILURE
			user_inter.story_box.show_story_box(user_inter.story_box.current_story)
			$"timers/month timer".stop()
			

func reset():
	"""called in story box to reset the game"""
	Story.player_stop = false
	get_tree().reload_current_scene()

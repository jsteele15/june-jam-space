class_name Space extends Node3D


@onready var planet_layer : Node = $planets
@onready var sound_board : SoundBoard = $sound_board
@onready var camera : Camera = $Camera3D
@onready var player : Player = $Player


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
	
	if event.is_action_pressed("ui_accept"):
		camera.zoom_level += 1
		print(camera.zoom_level)
		

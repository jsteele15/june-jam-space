class_name Space extends Node3D

@onready var player : Player = $Player
@onready var planet_layer : Node = $planets
@onready var game_camera : Camera3D = $"game camera"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.planet_orbiting = planet_layer.get_child(0)


func _input(event: InputEvent) -> void:
	#
	#	All the inputs for the game, 
	#	launch is space; you have to hold launch to leave planets atmosphere
	#	left and right are left and right, but will only work when not in atmosphere
	#
	if event.is_action_pressed("launch"):
		player.in_orbit = false
		player.firing_rockets = true
		
	if event.is_action_released("launch"):
		player.firing_rockets = false
		
	if event.is_action_pressed("rocketleft"):
		player.left_rockets = true
		
	if event.is_action_released("rocketleft"):
		player.left_rockets = false
		
	if event.is_action_pressed("rocketright"):
		player.right_rockets = true
		
	if event.is_action_released("rocketright"):
		player.right_rockets = false

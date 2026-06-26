class_name SoundBoard extends Node

@onready var world_ambiance : AudioStreamPlayer = $world_ambiance
@onready var rocket_player : AudioStreamPlayer = $rocket_player
@onready var track : AudioStreamPlayer = $track
@onready var pickup : AudioStreamPlayer = $pickup
@onready var fuel_stuff : AudioStreamPlayer = $fuelstuff
@onready var reset_play : AudioStreamPlayer = $resetplay

@onready var rocket_sound_1 = load("res://res/audio/sfx/sfx_rocket_sm/sfx_rocket_sm_01.wav")
@onready var rocket_sound_2 = load("res://res/audio/sfx/sfx_rocket_sm/sfx_rocket_sm_02.wav")
@onready var rocket_sound_3 = load("res://res/audio/sfx/sfx_rocket_sm/sfx_rocket_sm_03.wav")

@onready var get_fuel_sound = load("res://res/audio/sfx/Get Fuel.wav")
@onready var fuel_out_sound = load("res://res/audio/sfx/sfx_empty_fuel_v2.wav")
@onready var fuel_low_sound = load("res://res/audio/sfx/sfx_low_fuel_v2.wav")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	world_ambiance.play()
	track.play()


func fire_rockets():
	"""play in main? probabaly, where the rockets get fired"""
	var rocket_sound = [rocket_sound_1, rocket_sound_2, rocket_sound_3].pick_random()
	rocket_player.stream = rocket_sound
	rocket_player.pitch_scale = randf_range(0.8, 1.2)
	rocket_player.play()


func package_sound():
	"""called when player gets to the planets"""
	pickup.pitch_scale = randf_range(0.8, 1.2)
	pickup.play()


func fuel_func(fuel_action: int):
	fuel_stuff.pitch_scale = randf_range(0.8, 1.2)



	if fuel_action == 1: #collect fuel
		fuel_stuff.stream = get_fuel_sound
	if fuel_action == 2: #running out of fuel
		fuel_stuff.stream = fuel_low_sound
	if fuel_action == 3: #ran outa fuel
		fuel_stuff.stream = fuel_out_sound
	
	fuel_stuff.play()

func reset_player():
	reset_play.play()

class_name SoundBoard extends Node

@onready var world_ambiance : AudioStreamPlayer = $world_ambiance
@onready var rocket_player : AudioStreamPlayer = $rocket_player
@onready var track : AudioStreamPlayer = $track

@onready var rocket_sound_1 = load("res://res/audio/sfx/sfx_rocket_sm/sfx_rocket_sm_01.wav")
@onready var rocket_sound_2 = load("res://res/audio/sfx/sfx_rocket_sm/sfx_rocket_sm_02.wav")
@onready var rocket_sound_3 = load("res://res/audio/sfx/sfx_rocket_sm/sfx_rocket_sm_03.wav")

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

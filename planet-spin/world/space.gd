class_name Space extends Node3D

@onready var player : Player = $Player
@onready var planet_layer : Node = $planets

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.planet_orbiting = planet_layer.get_child(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

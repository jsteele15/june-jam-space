extends Node3D


var spin_speed : float = 1.0

func _ready() -> void:
	spin_speed = randf_range(0.2, 1.0)

func _on_timer_timeout() -> void:
	self.rotation_degrees.y += spin_speed

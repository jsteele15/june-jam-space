class_name Pivot extends Node3D

#attach a pivot to each planet,
#when ship goes into an atmosphere move the player onto this pivot
#this pivot spins, spinning the ship
#TODO change the spin direction based on what angle the player hits the planet
var spin_speed : float = 1.0
#TODO take into account player leaving


func _on_timer_timeout() -> void:
	self.rotation_degrees.y -= spin_speed

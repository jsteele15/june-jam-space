class_name Pivot extends Node3D

#attach a pivot to each planet,
#when ship goes into an atmosphere move the player onto this pivot
#this pivot spins, spinning the ship
#TODO change the spin direction based on what angle the player hits the planet
var spin_speed : float = 1.0
var amount_pivot_can_add : float = 1.0
var amount_given : float = 0.0
var amount_to_add : float = 0.01
#added a delay to stop it firing multiple times
var delay : bool = false
#TODO take into account player leaving

func pivot_dir(ship_angle : float):
	"""called in planet, change the direction """
	if delay == true:
		return
	if ship_angle >= 0:
		spin_speed = -1.0
	else:
		spin_speed = 1.0
	delay = true

func _on_timer_timeout() -> void:
	self.rotation_degrees.y -= spin_speed
	delay = false
	for c in self.get_children():
		if c is Player:
			if gameVars.player_speed < gameVars.MAX_SPEED and amount_given < amount_pivot_can_add:
				gameVars.player_speed += amount_to_add
				amount_given += amount_to_add
			else:
				return
	return
	

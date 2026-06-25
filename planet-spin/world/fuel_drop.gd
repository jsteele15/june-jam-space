class_name FuelDrop extends Node3D

@onready var fuel_image : Sprite3D = $"battery im"
@onready var spin_timer : Timer = $"spin timer"
@onready var respawn_timer : Timer = $"respawn timer"

var collected : bool = false
var fuel_add : int = 50

func _on_spin_timer_timeout() -> void:
	fuel_image.rotate_y(0.1)


func respawn():
	"""called somewhere, idk"""
	self.visible = true
	self.position.y = 0


func _collect():
	""""""
	if gameVars.fuel + fuel_add > gameVars.MAX_FUEL:
		gameVars.fuel = gameVars.MAX_FUEL
	else:
		gameVars.fuel += fuel_add
	
	collected = true
	self.visible = false
	self.position.y = -2000


func _on_area_3d_area_entered(area: Area3D) -> void:
	_collect()
	respawn_timer.start()


func _on_respawn_timer_timeout() -> void:
	respawn()

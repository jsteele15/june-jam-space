class_name FuelDrop extends Node3D

@onready var fuel_image : Sprite3D = $"battery im"
@onready var spin_timer : Timer = $"spin timer"
@onready var respawn_timer : Timer = $"respawn timer"

var drop_locations : Array = [Vector3(-8.547, 0, 0), Vector3(5.643, 0, 3.267), Vector3(-2.559, 0, -11.353)]
var collected : bool = false
var fuel_add : int = 100

func _on_spin_timer_timeout() -> void:
	fuel_image.rotate_y(0.1)


func respawn():
	"""called somewhere, idk"""
	self.visible = true
	self.position = drop_locations.pick_random()


func _collect():
	""""""
	self.get_parent().get_parent().sound_board.fuel_func(1)
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
	

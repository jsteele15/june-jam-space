class_name PackageCollection extends Node3D


var package_list : Array = []
var package_destination : Array = []

func _ready() -> void:
	package_list = self.get_children()
	for c in self.get_child_count():
		package_destination.append(gameVars.PLANETS.None)

func _choose_package_destination(pack : int):
	"""want this to me more complex, but itll do for now"""
	#TODO set colour of package as well
	package_destination[pack] = gameVars.PLANETS.MERCURY


func set_new_package():
	"""call this in planets at certain intevals to place a new package"""

	for p in self.get_child_count():
		if self.get_child(p).visible == false:
			_choose_package_destination(p)
			self.get_child(p).visible = true
			break

		#also set its destination by colour
		

func pick_up_package(player : Player):
	"""call in planet, when they land on the planet, put stuff on the players cargo"""
	for p in self.get_child_count():
		if self.get_child(p).visible == true:
			for c in range(0, len(player.cargo)-1):
				if player.cargo[c] == gameVars.PLANETS.None:
					player.add_cargo(gameVars.PLANETS.MERCURY, c)
					self.get_child(p).visible = false
					break
		else:
			break
	

class_name PackageCollection extends Node3D


var package_list : Array = []
var package_destination : Array = []

func _ready() -> void:
	package_list = self.get_children()
	for c in self.get_child_count():
		package_destination.append(gameVars.PLANETS.None)

func _choose_package_destination(pack : int):
	"""want this to me more complex, but itll do for now"""
	#TODO change this up so new planets can come online
	var planet_options : Array = [gameVars.PLANETS.SUN, gameVars.PLANETS.MERCURY, gameVars.PLANETS.VENUS, gameVars.PLANETS.EARTH, gameVars.PLANETS.MOON]
	var filtered_options = planet_options.filter(func(i): return i != self.get_parent().planet_name)

	var planet_chosen : int = filtered_options.pick_random()
	package_destination[pack] = planet_chosen
	self.get_child(pack).modulate = gameVars.planet_colours[planet_chosen]


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
					player.add_cargo(package_destination[p], c)
					self.get_child(p).visible = false
					break
		else:
			break
	

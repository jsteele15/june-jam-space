class_name PackageCollection extends Node3D


var package_list : Array = []
var package_destination : Array = []
var planet_options : Array = []

func _ready() -> void:
	package_list = self.get_children()
	for c in self.get_child_count():
		package_destination.append(gameVars.PLANETS.None)

func _choose_package_destination(pack : int):
	"""want this to me more complex, but itll do for now"""
	print("\nPlanet options ", planet_options)
	if len(planet_options) == 0:
		return
	if len(planet_options) == 1:
		if planet_options[0] == get_parent().planet_name:
			return
	#TODO change this up so new planets can come online
	var filtered_options = planet_options.filter(func(i): return i != self.get_parent().planet_name)
	print("Filtered ", filtered_options)
	var planet_chosen : int = filtered_options.pick_random()
	package_destination[pack] = planet_chosen
	self.get_child(pack).modulate = gameVars.planet_colours[planet_chosen]


func set_new_package():
	"""call this in planets at certain intevals to place a new package"""
	if len(planet_options) == 0:
		return
		
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
	

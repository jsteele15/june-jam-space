extends Camera3D

func firing():
	"""to allow for screen shake and changes of field of view 
	for fast motion"""
	if gameVars.player.firing_rockets == true:
		if self.fov < 20.0:
			self.fov += 0.1
	else:
		if self.fov > 15.0:
			self.fov -= 0.1

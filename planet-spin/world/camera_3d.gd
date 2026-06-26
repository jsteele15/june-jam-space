class_name Camera extends Camera3D

var zoom_sizes: Array = [1, 30, 60, 100, 150, 150]
var zoom_level: int = 0

@onready var player : Player = null

var end_x : int = 0

var zoom_speed: float = 0.2
var death_trig : bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if gameVars.game_started == true:
		if global_position.x < end_x:
			self.global_position.x += 0.1
		else:
			if self.get_parent().is_player_off_screen(gameVars.player, self):
				if gameVars.fuel <= 0 and death_trig == false:
					self.get_parent().user_inter.story_box.current_story = Story.STORY_BEAT.OUT_OF_FUEL
					self.get_parent().user_inter.story_box.show_story_box(Story.STORY_BEAT.OUT_OF_FUEL)
					death_trig = true
				else:
					self.get_parent().reset_player_on_screen()
	
	if zoom_level < len(zoom_sizes) - 1:
		if self.size < zoom_sizes[zoom_level]:
			self.size += zoom_speed
		if self.player == null:
			self.player = get_parent().player
	else:
		## Camera follow logic to go here
		self.global_position.x = player.global_position.x
		## No Y so camera stays above ship and planets
		self.global_position.z = player.global_position.z

func next_zoom(level: int) -> void:
	if level > 2:
		return
	

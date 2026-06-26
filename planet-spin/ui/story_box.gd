class_name StoryBox extends Control

@onready var char_im : TextureRect = $"char im"
@onready var mission_text : GameText = $"game text"
@onready var typing_sound : AudioStreamPlayer = $typing

var pelap_im = load("res://res/char heads/delpa.png")
var boza = load("res://res/char heads/boza.png")
var battery_inf = load("res://res/char heads/batteryinf.png")

var current_story : int = Story.STORY_BEAT.OPENING_TEXT
var text_speed := 30.0
var t := 0.0


func _process(delta):
	#TODO add the typeing sound
	if mission_text.visible_characters < mission_text.get_total_character_count():
		t += delta * text_speed
		mission_text.visible_characters = int(t)
	else:
		typing_sound.stop()

func show_story_box(story_part : int):
	"""called under some condition, the story_part will refer to """
	self.visible = true
	typing_sound.pitch_scale = randf_range(0.8, 1.2)
	typing_sound.play()
	mission_text.visible_characters = 0
	t = 0.0
	
	match story_part:
		Story.STORY_BEAT.OPENING_TEXT:
			char_im.texture = boza
			mission_text.text = Story.text_dict[story_part]
		Story.STORY_BEAT.PACKAGE_DROPS:
			char_im.texture = pelap_im
			mission_text.text = Story.text_dict[story_part]
		Story.STORY_BEAT.SPACE_BAR:
			char_im.texture = boza
			mission_text.text = Story.text_dict[story_part]
		Story.STORY_BEAT.LEFT_RIGHT:
			char_im.texture = boza
			mission_text.text = Story.text_dict[story_part]
		Story.STORY_BEAT.FUEL:
			char_im.texture = battery_inf
			mission_text.text = Story.text_dict[story_part]
		Story.STORY_BEAT.STORY_END_FAILURE:
			$"quest button".visible = true
			char_im.texture = boza
			mission_text.text = "{store} 
			score : {score}".format({"store": Story.text_dict[story_part], "score": gameVars.current_cash})
		Story.STORY_BEAT.STORY_END_SUCCESS:
			$"quest button".visible = true
			char_im.texture = boza
			mission_text.text = "{store} 
			score : {score}".format({"store": Story.text_dict[story_part], "score": gameVars.current_cash}) 
		Story.STORY_BEAT.OFFSCREEN:
			$"quest button".visible = false
			char_im.texture = boza
			mission_text.text = Story.text_dict[story_part]
			$"offscreen text".start()
		Story.STORY_BEAT.ROUTE:
			$"quest button".visible = false
			char_im.texture = boza
			mission_text.text = Story.text_dict[story_part]
			$"expansion timer".start()
		Story.STORY_BEAT.OUT_OF_FUEL:
			$"quest button".visible = true
			char_im.texture = boza
			mission_text.text = Story.text_dict[story_part]
			
#
#
#	for the next button
#
func _on_quest_button_mouse_entered() -> void:
	$"quest button/ColorRect".visible = true
	$"quest button/game text2".colour_black()
	self.get_parent().button_hover_sound.play()


func _on_quest_button_mouse_exited() -> void:
	$"quest button/ColorRect".visible = false
	$"quest button/game text2".colour_yellow()
	self.get_parent().button_hover_sound.play()


func _input(event: InputEvent) -> void:
	""""""
	if Story.tutorial_done == true:
		return
	
	if event.is_action_pressed("launch"):
		if Story.show_space == true:
			Story.player_stop = false
			current_story = Story.STORY_BEAT.LEFT_RIGHT
			Story.show_space = false
			Story.show_l_r = true
			show_story_box(current_story)
			return
	
	if event.is_action_pressed("rocketleft") or event.is_action_pressed("rocketright"):
		if Story.show_l_r == true:
			current_story = Story.STORY_BEAT.FUEL
			Story.show_l_r = false
			$"quest button".visible = true
			show_story_box(current_story)
			return

func _on_quest_button_pressed() -> void:
	
	if current_story == Story.STORY_BEAT.OPENING_TEXT:
		if Story.tutorial_done == false:
			current_story = Story.STORY_BEAT.PACKAGE_DROPS
			show_story_box(current_story)
			return
		else:
			self.visible = false
		
	if current_story == Story.STORY_BEAT.PACKAGE_DROPS:
		current_story = Story.STORY_BEAT.SPACE_BAR
		$"quest button".visible = false
		Story.show_space = true
		show_story_box(current_story)
		return
		
	if current_story == Story.STORY_BEAT.FUEL:
		$"quest button".visible = false
		self.visible = false
		Story.tutorial_done = true
		return
		
	if current_story == Story.STORY_BEAT.STORY_END_SUCCESS or current_story == Story.STORY_BEAT.STORY_END_FAILURE or current_story == Story.STORY_BEAT.OUT_OF_FUEL:
		gameVars.reset()
		get_parent().get_parent().reset()
		return


func _on_offscreen_text_timeout() -> void:
	self.visible = false


func _on_expansion_timer_timeout() -> void:
	self.visible = false

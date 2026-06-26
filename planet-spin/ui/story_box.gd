class_name StoryBox extends Control

@onready var char_im : TextureRect = $"char im"
@onready var mission_text : GameText = $"game text"

var current_story : int = Story.STORY_BEAT.OPENING_TEXT
var text_speed := 30.0
var t := 0.0


func _process(delta):
	#TODO add the typeing sound
	if mission_text.visible_characters < mission_text.get_total_character_count():
		t += delta * text_speed
		mission_text.visible_characters = int(t)


func show_story_box(story_part : int):
	"""called under some condition, the story_part will refer to """
	mission_text.visible_characters = 0
	mission_text.text = Story.text_dict[story_part]

#
#
#	for the next button
#
func _on_quest_button_mouse_entered() -> void:
	$"quest button/ColorRect".visible = true
	$"quest button/game text2".colour_black()


func _on_quest_button_mouse_exited() -> void:
	$"quest button/ColorRect".visible = false
	$"quest button/game text2".colour_yellow()


func _on_quest_button_pressed() -> void:
	pass # Replace with function body.

class_name GameText extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func colour_yellow():
	""""""
	self.add_theme_color_override("default_color", Color(0.918, 0.753, 0.086, 1.0))
	
func colour_black():
	""""""
	self.add_theme_color_override("default_color", Color(0.0, 0.0, 0.0, 1.0))

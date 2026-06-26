class_name GameButton extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_mouse_entered() -> void:
	self.get_child(0).visible = true
	self.get_child(1).colour_black()
	self.get_parent().get_parent().get_parent().button_hover_sound.play()


func _on_mouse_exited() -> void:
	self.get_child(0).visible = false
	self.get_child(1).colour_yellow()
	self.get_parent().get_parent().get_parent().button_hover_sound.play()

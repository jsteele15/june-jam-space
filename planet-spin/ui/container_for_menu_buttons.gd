extends GridContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_game_button_start_pressed() -> void:
	self.get_parent().get_parent().start_game()
	


func _on_game_button_credits_pressed() -> void:
	$"../credits".visible = true
	for c in $"../credits/GridContainer".get_children():
		c.colour_black()

class_name ui extends CanvasLayer


@onready var fuel_bar : TextureProgressBar = $ProgressBar
@onready var container_for_cargo : GridContainer = $"control for cargo/container for cargo"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _change_cargo_colour():
	
	for c in range(0, len(gameVars.player.cargo)):
		if gameVars.player.cargo[c] == gameVars.PLANETS.None:
			container_for_cargo.get_child(c).visible = false
		else:
			container_for_cargo.get_child(c).visible = true
	
			container_for_cargo.get_child(c).modulate = gameVars.planet_colours[gameVars.player.cargo[c]]


func _on_timer_timeout() -> void:
	fuel_bar.value = gameVars.fuel
	_change_cargo_colour()

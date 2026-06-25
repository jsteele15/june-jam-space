class_name ui extends CanvasLayer


@onready var fuel_bar : TextureProgressBar = $ProgressBar
@onready var container_for_cargo : GridContainer = $"control for cargo/container for cargo"
@onready var money_text : GameText = $"money text"
@onready var control_for_main_menu = $"control for main menu"
# Called when the node enters the scene tree for the first time.

var package_circle = load("res://res/ui elements/packagecircle.png")
var package_square = load("res://res/ui elements/packagesquare.png")
var package_triangle = load("res://res/ui elements/packagetriangle.png")

func _ready() -> void:
	pass # Replace with function body.


func _decide_package_image(dest : int):
	"""based on the package delivery destination, change the shape"""
	var shape
	
	if gameVars.planet_shapes[dest] == gameVars.SHAPES.circle:
		return package_circle
	
	if gameVars.planet_shapes[dest] == gameVars.SHAPES.square:
		return package_square
	
	if gameVars.planet_shapes[dest] == gameVars.SHAPES.triangle:
		return package_triangle

func _change_cargo_colour():
	
	for c in range(0, len(gameVars.player.cargo)):
		if gameVars.player.cargo[c] == gameVars.PLANETS.None:
			container_for_cargo.get_child(c).visible = false
		else:
			container_for_cargo.get_child(c).visible = true
			container_for_cargo.get_child(c).texture = _decide_package_image(gameVars.player.cargo[c])
			container_for_cargo.get_child(c).modulate = gameVars.planet_colours[gameVars.player.cargo[c]]

func start_game():
	"""called in the start game button"""
	control_for_main_menu.free()
	gameVars.game_started = true
	fuel_bar.visible = true

	money_text.visible = true

func _on_timer_timeout() -> void:
	fuel_bar.value = gameVars.fuel
	_change_cargo_colour()
	money_text.text = "[center]{cash}".format({"cash": gameVars.current_cash})

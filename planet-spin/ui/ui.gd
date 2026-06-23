class_name ui extends CanvasLayer

@onready var current_time_text : GameText = $"container for text ui/container for objectives/current time"
@onready var speed_text : GameText = $"container for text ui/speed text"
@onready var current_mission_text : GameText = $"container for text ui/container for objectives/current mission"
@onready var fuel_text : GameText = $"container for text ui/fuel text"
@onready var fuel_bar : TextureProgressBar = $ProgressBar
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_timer_timeout() -> void:
	speed_text.text = "[center]CURRENT SPEED {cur_speed}".format({"cur_speed" : gameVars.player_speed*1000})
	current_mission_text.text = "[center]CURRENT DESTINATION MISSION {place}".format({"place": gameVars.planet_mission_text[gameVars.current_mission]})
	fuel_text.text = "[center]CURRENT FUEL {fuel}".format({"fuel": gameVars.fuel})
	fuel_bar.value = gameVars.fuel

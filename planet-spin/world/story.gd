extends Node


#
#
#	will containe a buncha fuckin story functions
#
#
var tutorial_done : bool = false
var stop_ship : bool = false
var show_space : bool = false
var show_l_r : bool = false #TODO continue this

enum STORY_BEAT {
	None = -1,
	OPENING_TEXT = 0,
	SPACE_BAR = 1,
	LEFT_RIGHT,
	FUEL,
	PACKAGE_DROPS,
	
}

var text_dict : Dictionary = {
	STORY_BEAT.OPENING_TEXT : "Welcome to Day One at VOID COURIER! All new hires pilot our rental spaceships…at a rate of Ų3,33/parsec. Fail to repay your debt in a timely manner and we’ll withdraw premium benefits, such as oxygen.",
	STORY_BEAT.SPACE_BAR : "press --SPACE BAR-- to break free of planets orbits.",
	STORY_BEAT.LEFT_RIGHT : "USE --D and A-- or --ARROW KEYS-- to angle your ship.",
	STORY_BEAT.FUEL : "Be mindful of fuel levels! Lacking fuel to leave planets will result in immediate termination!",
	STORY_BEAT.PACKAGE_DROPS : "Move packages to planets of the same colour!",
}

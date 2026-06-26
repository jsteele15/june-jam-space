extends Node


#
#
#	will containe a buncha fuckin story functions
#
#
var tutorial_done : bool = false
var stop_ship : bool = false
var show_space : bool = false
var show_l_r : bool = false 
var player_stop : bool = false

enum STORY_BEAT {
	None = -1,
	OPENING_TEXT = 0,
	SPACE_BAR = 1,
	LEFT_RIGHT,
	FUEL,
	PACKAGE_DROPS,
	STORY_END_SUCCESS,
	STORY_END_FAILURE,
	OFFSCREEN,
	OUT_OF_FUEL,
	ROUTE,
}

var text_dict : Dictionary = {
	STORY_BEAT.OPENING_TEXT : "Welcome to Day One at VOID COURIER! All new hires pilot our rental spaceships…at a rate of Ų3,33/parsec. Fail to repay your debt in a timely manner and we’ll withdraw premium benefits, such as oxygen.",
	STORY_BEAT.SPACE_BAR : "press --SPACE BAR-- to break free of planets orbits.",
	STORY_BEAT.LEFT_RIGHT : "USE --D and A-- or --ARROW KEYS-- to angle your ship.",
	STORY_BEAT.FUEL : "Be mindful of fuel levels! Lacking fuel to leave planets will result in immediate termination!",
	STORY_BEAT.PACKAGE_DROPS : "Move packages to planets of the same colour!",
	STORY_BEAT.STORY_END_SUCCESS : "How about that, you are still alive! Keep on keepin’ on, kiddo. Money to be made. For us.",
	STORY_BEAT.STORY_END_FAILURE : "Look at that clock tick! Look at that debt accrue! Better pilot faster and better, it’s game over, sweetheart.",
	STORY_BEAT.OFFSCREEN : "Whoa, rein it in, cowgirl. You can’t steal the ship, remember? We’ll shut your loaner ship down remotely. Now, back on your route!",
	STORY_BEAT.OUT_OF_FUEL : "Without fuel you died. YOUR DEBTS PASS ON TO YOUR NEXT OF KIN",
	STORY_BEAT.ROUTE : "Good job! You’re not dead! Your route has been expanded.",
}

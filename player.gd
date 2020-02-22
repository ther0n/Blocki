extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const MOVE_ACCEL = 500.0
const MOVE_DEACCEL = 500.0
const MOVE_MAX_VELOCITY = 140.0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _integrate_forces(state):
	var lv = state.get_linear_velocity()
	var step = state.get_step()

	# Get the controls.
	var move_left = Input.is_action_pressed("player_left")
	var move_right = Input.is_action_pressed("player_right")

	if move_left:
		if lv.x > -MOVE_MAX_VELOCITY:
			lv.x -= MOVE_ACCEL * step
	elif move_right:
		if lv.x < MOVE_MAX_VELOCITY:
			lv.x += MOVE_ACCEL * step
	state.set_linear_velocity(lv)


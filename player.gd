extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const MOVE_ACCEL = 1000.0
const MOVE_DEACCEL = 2000.0
const MOVE_FALL = 1000.0
const MOVE_MAX_VELOCITY = 3000.0
const JUMP_VELOCITY = 380
var device_id = -1


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	

func _integrate_forces(state):
	var lv = state.get_linear_velocity()
	var step = state.get_step()

	# Get the controls.
	
	var move_x = Input.get_joy_axis(device_id, JOY_AXIS_0)
	var move_y = Input.get_joy_axis(device_id, JOY_AXIS_1)
	var jump = Input.is_joy_button_pressed(device_id, JOY_BUTTON_0)

	if abs(lv.x) < MOVE_MAX_VELOCITY:
		if sign(lv.x) != sign(move_x):
			lv.x += move_x * MOVE_DEACCEL * step
		lv.x += move_x * MOVE_ACCEL * step

	if move_y > 0: 
		lv.y += move_y * MOVE_FALL * step
		
	if jump:
		lv.y = -JUMP_VELOCITY

	state.set_linear_velocity(lv)


func set_device_id(new_device_id):
	device_id = new_device_id


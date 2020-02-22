extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const MOVE_ACCEL = 500.0
const MOVE_DEACCEL = 500.0
const MOVE_MAX_VELOCITY = 140.0
var device_id = -1


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _fire_cube():
	var aim_x = Input.get_joy_axis(device_id, 2)
	var aim_y = Input.get_joy_axis(device_id, 3)
	var aim_rotation = Vector2(aim_x, aim_y).angle()
	

func _integrate_forces(state):
	var lv = state.get_linear_velocity()
	var step = state.get_step()

	# Get the controls.
	var move_x = Input.get_joy_axis(device_id, 0)
	#var move_right = Input.is_action_pressed("player_right")

	if abs(lv.x) < MOVE_MAX_VELOCITY:
		lv.x += move_x * MOVE_ACCEL * step

	state.set_linear_velocity(lv)


func set_device_id(new_device_id):
	device_id = new_device_id

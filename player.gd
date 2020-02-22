extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const MOVE_ACCEL = 500.0
const MOVE_DEACCEL = 500.0
const MOVE_MAX_VELOCITY = 140.0
var device_id = -1

var aim_x
var aim_y
var move_x
var move_y
var aim_angle


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func process(delta):
	add_force(Vector2(0,0),Vector2(0,1))

func _integrate_forces(state):
	var lv = state.get_linear_velocity()
	var step = state.get_step()
	
	# Get the controls.
	update_inputs()
	$Gun.rotation = aim_angle - rotation

	if abs(lv.x) < MOVE_MAX_VELOCITY:
		lv.x += move_x * MOVE_ACCEL * step

	state.set_linear_velocity(lv)


#func fire_cube():
#	var block = block.instance()
#	block.set_position(get_position_in_parent())
#	World.add_child(block)
	

func update_inputs():
	move_x = Input.get_joy_axis(device_id, 0)
	move_y = Input.get_joy_axis(device_id, 1)
	aim_x = Input.get_joy_axis(device_id, 2)
	aim_y = Input.get_joy_axis(device_id, 3)
	aim_angle = Vector2(aim_x, aim_y).angle()

func set_device_id(new_device_id):
	device_id = new_device_id

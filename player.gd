extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const MOVE_ACCEL = 1000.0
const MOVE_DEACCEL = 2000.0
const MOVE_FALL = 2000.0
const MOVE_MAX_VELOCITY = 3000.0
const JUMP_VELOCITY = 900.0
var device_id = -1

var aim_x
var aim_y
var move_x
var move_y
var jump
var aim_angle


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func process(delta):
	add_force(Vector2(1,0),Vector2(0,1))

func _integrate_forces(state):
	var lv = state.get_linear_velocity()
	var step = state.get_step()
	
	# Get the controls.
	update_inputs()
	$Gun.rotation = aim_angle - rotation
	
	var found_floor = false
	for x in range(state.get_contact_count()):
		var ci = state.get_contact_local_normal(x)
		if ci.dot(Vector2(0, -1)) > 0.6:
			found_floor = true

	if abs(lv.x) < MOVE_MAX_VELOCITY:
		if sign(lv.x) != sign(move_x):
			lv.x += move_x * MOVE_DEACCEL * step
		lv.x += move_x * MOVE_ACCEL * step

	if move_y > 0: 
		lv.y += move_y * MOVE_FALL * step
		
	if jump && found_floor:
		lv.y = -JUMP_VELOCITY

	state.set_linear_velocity(lv)


#func fire_cube():
#	var block = block.instance()
#	block.set_position(get_position_in_parent())
#	World.add_child(block)
	

func update_inputs():
	move_x = Input.get_joy_axis(device_id, JOY_AXIS_0)
	move_y = Input.get_joy_axis(device_id, JOY_AXIS_1)
	jump = Input.is_joy_button_pressed(device_id, JOY_BUTTON_0)
	aim_x = Input.get_joy_axis(device_id, JOY_AXIS_2)
	aim_y = Input.get_joy_axis(device_id, JOY_AXIS_3)
	aim_angle = Vector2(aim_x, aim_y).angle()

func set_device_id(new_device_id):
	device_id = new_device_id

extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const MOVE_ACCEL = 2000.0
const MOVE_DEACCEL = 2000.0
const MOVE_FALL = 2000.0
const MOVE_MAX_VELOCITY = 800.0
const JUMP_VELOCITY = 1500.0
const JUMP_TIME = 0.15
var device_id = -1

onready var block = preload("res://block.tscn")

onready var shot_cooldown = $ShotCooldown

var aim_x
var aim_y
var move_x
var move_y
var jump
var shoot
var can_jump = 0
var aim_angle


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _integrate_forces(state):
	var lv = state.get_linear_velocity()
	var step = state.get_step()
	
	# Get the controls.
	update_inputs()
	$Gun.rotation = aim_angle - rotation
	
	var floor_normal
	var wall_normal
	for x in range(state.get_contact_count()):
		var ci = state.get_contact_local_normal(x)
		if ci.dot(Vector2(0, -1)) > 0.6:
			floor_normal = ci
		if ci.dot(Vector2(0, -1)) > -0.7:
			wall_normal = ci
			
	if sign(lv.x) != sign(move_x):
		lv.x += move_x * MOVE_DEACCEL * step
	if abs(lv.x) < MOVE_MAX_VELOCITY:
		lv.x += move_x * MOVE_ACCEL * step

	if move_y > 0: 
		lv.y += move_y * MOVE_FALL * step
	
	if can_jump > 0:
		can_jump -= step
		
	if jump && can_jump <= 0:
		if floor_normal != null:
			can_jump = 0.15
			lv.y = -JUMP_VELOCITY
		elif wall_normal != null:
			can_jump = 0.15
			lv.y = -JUMP_VELOCITY/1.2
			lv.x = wall_normal.x * JUMP_VELOCITY/1.6

	if shoot and shot_cooldown.is_stopped():
		shot_cooldown.start()
		var new_block = block.instance()
		new_block.position = position
		var root = get_tree().get_root()
		var current_scene = root.get_child(root.get_child_count() -1)
		current_scene.add_child(new_block)

	state.set_linear_velocity(lv)


#func fire_cube():
#	var block = block.instance()
#	block.set_position(get_position_in_parent())
#	World.add_child(block)
	

func update_inputs():
	move_x = Input.get_joy_axis(device_id, JOY_AXIS_0)
	move_y = Input.get_joy_axis(device_id, JOY_AXIS_1)
	jump = Input.is_joy_button_pressed(device_id, JOY_BUTTON_0)
	shoot = Input.is_joy_button_pressed(device_id, JOY_BUTTON_6)
	aim_x = Input.get_joy_axis(device_id, JOY_AXIS_2)
	aim_y = Input.get_joy_axis(device_id, JOY_AXIS_3)
	aim_angle = Vector2(aim_x, aim_y).angle()

func set_device_id(new_device_id):
	device_id = new_device_id

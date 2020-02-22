extends Sprite

const SPEED = 300
var velocity = Vector2()

master var puppet_pos
puppet var puppet_movement = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	if is_network_master():
		$NameLabel.text = "You"
	else:
		#var player_id = get_network_master()
		#$NameLabel.text = gamestate.players[player_id]
		$NameLabel.text = "idk"
		puppet_pos = position # Just making sure we initilize it


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_network_master():
		
#		if Input.is_action_pressed("up"):
#			move_dir.y -= 1
#		if Input.is_action_pressed("down"):
#			move_dir.y += 1
		if Input.is_action_pressed("left"):
			puppet_movement = 500
		elif Input.is_action_pressed("right"):
			puppet_movement = -500
		else:
			puppet_movement = 0
		rset_unreliable("puppet_movement", puppet_movement)
		#rset_unreliable("puppet_pos", position)
		#rset_unreliable("puppet_vel", velocity)
	else:
		# If we are not the ones controlling this player, 
		# sync to last known position and velocity
		position = puppet_pos
	
	#position += velocity * delta
	
	if not is_network_master():
		# It may happen that many frames pass before the controlling player sends
		# their position again. If we don't update puppet_pos to position after moving,
		# we will keep jumping back until controlling player sends next position update.
		# Therefore, we update puppet_pos to minimize jitter problems
		puppet_pos = position

remote func update_position(new_position):
	position = new_position

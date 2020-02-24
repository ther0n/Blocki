extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var player = preload("res://player.tscn")
var players = []
var colors = []
var debug = false

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	
	colors.resize(20)
	for c in 20:
		colors[c] = Color(randf(), randf(), randf())
	start_game()

func start_game():
	players = []
	for controller in Input.get_connected_joypads():
		print(controller)
		var new_player = player.instance()
		new_player.position = Vector2(randi()%25 +3200, randi()%15+960)
		new_player.set_device_id(controller)
		new_player.set_id(players.size())
		players.append(new_player)
	var keyboard_player = player.instance()
	keyboard_player.position = Vector2(randi()%25 +3200, randi()%15+960)
	keyboard_player.set_keyboard(true)
	keyboard_player.set_id(players.size())
	players.append(keyboard_player)
	
	if debug:
		var debugPlayer = player.instance()
		debugPlayer.position = Vector2(randi()%25 +3200, randi()%15+960)
		debugPlayer.set_id(players.size())
		players.append(debugPlayer)	
	
func _input(event: InputEvent):
	if event.is_action_pressed("fullscreen"):
		OS.set_window_fullscreen(!OS.is_window_fullscreen())
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

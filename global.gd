extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var player = preload("res://player.tscn")
var players = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for controller in Input.get_connected_joypads():
		print(controller)
		var new_player = player.instance()
		new_player.position = Vector2(randi()%25 +3200, randi()%15+960)
		new_player.set_device_id(controller)
		players.append(new_player)
	var keyboard_player = player.instance()
	keyboard_player.position = Vector2(randi()%25 +3200, randi()%15+960)
	keyboard_player.set_keyboard(true)
	players.append(keyboard_player)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

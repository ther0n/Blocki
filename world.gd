extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var players = []
onready var win_timer = $WinTimer


# Called when the node enters the scene tree for the first time.
func _ready():
	start_game()


func start_game():
	players = []
	for player in Global.players:
		var root = get_tree().get_root()
		var current_scene = root.get_child(root.get_child_count() -1)
		current_scene.add_child(player)
		players.append(player)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func win_and_restart(player):
	var winner = Global.players.find(player) + 1
	print("Player " + str(winner) + " won the game!")
	$CanvasLayer/RichTextLabel.set_text("Player " + str(winner) + " won the game!")
	$CanvasLayer/RichTextLabel.visible = true
	win_timer.start()
	yield(win_timer, "timeout")
	$CanvasLayer/RichTextLabel.visible = false
	print("Restarting")
	get_tree().set_pause(true)
	for player in players:
		players.remove(players.find(player))
		player.queue_free()
	$TileMap.gen_map()
	Global.start_game()
	start_game()
	get_tree().set_pause(false)


func _on_Area2D_body_entered(body):
	body.queue_free()
	if body in players:
		players.remove(players.find(body))
	if players.size() == 1 and win_timer.is_stopped():
		win_and_restart(players[0])

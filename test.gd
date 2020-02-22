extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var players = []


# Called when the node enters the scene tree for the first time.
func _ready():
	for player in Global.players:
		var root = get_tree().get_root()
		var current_scene = root.get_child(root.get_child_count() -1)
		current_scene.add_child(player)
		players.append(player)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	body.queue_free()
	if body in players:
		players.remove(players.find(body))

extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var lifetime = $Lifetime

# Called when the node enters the scene tree for the first time.
func _ready():
	lifetime.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if lifetime.is_stopped():
		queue_free()
	var lifetime_ratio = lifetime.time_left/lifetime.wait_time
	scale = Vector2(lifetime_ratio, lifetime_ratio)
	$CollisionShape2D.scale = Vector2(lifetime_ratio, lifetime_ratio)
	mass = lifetime_ratio


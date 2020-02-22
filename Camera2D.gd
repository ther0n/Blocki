extends Camera2D

var one = 300

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var minx = 999999
	var miny = 999999
	var maxx = -999999
	var maxy = -999999
	
	for player in Global.players:
		var position = player.position
		if position.x < minx:
			minx = position.x
		if position.x > maxx:
			maxx = position.x
		if position.y < miny:
			miny = position.y
		if position.y > maxy:
			maxy = position.y
	
	offset = Vector2((minx +  maxx)/2, (miny + maxy)/2)
	var zoomVal = max(max(1.5, (maxx - minx)/one), max(1.5,(maxy - miny)/one))
	zoom = Vector2(zoomVal, zoomVal)
	#print(zoom)
	
#	pass

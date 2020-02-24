extends Camera2D

var xzoom = 750
var yzoom = 450
var minzoom = 2.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var minx = 999999
	var miny = 999999
	var maxx = -999999
	var maxy = -999999
	for player in $"..".players:
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
	var zoomVal = max(max(minzoom, (maxx - minx)/xzoom), max(minzoom,(maxy - miny)/yzoom))
	zoom = Vector2(zoomVal, zoomVal)
	
#	pass

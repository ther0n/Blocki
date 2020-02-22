extends TileMap

var grid = []
var noise = OpenSimplexNoise.new()
var cull_val = 0.1
var xsize = 128
var ysize = 48

# Called when the node enters the scene tree for the first time.
func _ready():
	noise.seed = randi()
	noise.octaves = 3
	noise.period =  10.0
	
	grid.resize(xsize)
	for n in xsize:
		grid[n] = []
		grid[n].resize(xsize)
		for m in ysize:
			var noiseVal = noise.get_noise_2d(n, m)
			if (noiseVal > cull_val):
				#print(noiseVal)
				grid[n][m]=9
			else:
				grid[n][m]=-1
	
	for n in randi()%5+3:
		var yval = randi()%(ysize - 20) + 10
		var xval = randi()%(xsize - 20) + 10
		var num = randi()%7+4
		
		for l in range(0, num):				
			if grid[xval+l][yval]==-1:
				if l==0 or l==num-1:
					grid[xval+l][yval]=0
				else:
					grid[xval+l][yval]=1
	
	for n in range(0,xsize - 1):
		for m in range(0, ysize-1):
			set_cell(n, m, grid[n][m])

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

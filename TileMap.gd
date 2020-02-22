extends TileMap

var grid = []
var noise = OpenSimplexNoise.new()
var cull_val = .5
var xsize = 50
var ysize = 32

# Called when the node enters the scene tree for the first time.
func _ready():
	#randomize()
	noise.seed = 23
	noise.octaves = 3
	noise.period =  10.0
	
	grid.resize(xsize)
	for n in xsize:
		grid[n] = []
		grid[n].resize(xsize)
		for m in ysize:
			var noiseVal = (noise.get_noise_2d(n, m) + 1) / 2
			
			if (noiseVal * (2*m / ysize) > cull_val):
				#print(noiseVal * (2*m / ysize))
				grid[n][m] = 1
			else:
				grid[n][m] = -1
	
	for n in xsize:
		for m in ysize:
			var emptyL
			var emptyR
			var emptyU
			var emptyD
			
			var inputVal = 9
			
			if (grid[n][m] != -1):
				if (n==0 or grid[n-1][m]==-1):
					emptyL =  true
				if (n==xsize-1 or grid[n+1][m]==0):
					emptyR = true
				if (m==0 or grid[n][m-1]==-1):
					emptyU = true
				if (m==ysize-1 or grid[n][m+1]==0):
					emptyD = true
				if (emptyL and emptyR and emptyU and emptyD):
					pass
				elif(emptyL and emptyR and emptyD):
					pass
				elif(emptyL and emptyR and emptyU):
					pass
				elif(emptyL and emptyU and not emptyR and not emptyD):
					inputVal = 2
				elif(emptyR and emptyU and not emptyL and not emptyD):
					inputVal = 4
				elif(emptyU and not emptyR and not emptyD and not emptyL):
					inputVal = 3
					
					if (m != 0):
						grid[n][m-1] = 8
				
				grid[n][m] = inputVal
			else:
				grid[n][m]=-1
	
	for n in randi()%3+3:
		var yval = randi()%(ysize - 14) + 7
		var xval = randi()%(xsize - 14) + 7
		var num = randi()%3+4
		
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

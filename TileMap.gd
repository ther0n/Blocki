extends TileMap

var grid = []
var noise = OpenSimplexNoise.new()
var cull_val = .5
var xsize = 50
var ysize = 32

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	noise.seed = randi()
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
				if (n==0 or grid[n-1][m]==-1 or grid[n-1][m]==8):
					emptyL =  true
				if (n==xsize-1 or grid[n+1][m]==-1 or grid[n+1][m]==8):
					emptyR = true
				if (m==0 or grid[n][m-1]==-1 or grid[n][m-1]==8):
					emptyU = true
				if (m==ysize-1 or grid[n][m+1]==-1 or grid[n][m+1]==8):
					emptyD = true
					
				if (emptyL and emptyR and emptyU and emptyD):
					inputVal = 14
				elif(emptyL and emptyR and emptyD and not emptyU):
					inputVal = 13
				elif(emptyL and emptyR and emptyU and not emptyD):
					inputVal = 12
				elif(emptyL and emptyD and not emptyR and not emptyU):
					inputVal = 11
				elif(emptyR and emptyD and not emptyL and not emptyU):
					inputVal = 10
				elif(emptyL and emptyU and not emptyR and not emptyD):
					inputVal = 2
				elif(emptyR and emptyU and not emptyL and not emptyD):
					inputVal = 4
				elif(emptyL and emptyU and emptyD and not emptyR):
					inputVal = 16
					if (m != 0):
						grid[n][m-1] = 8
				elif(emptyR and emptyU and emptyD and not emptyL):
					inputVal = 15
					if (m != 0):
						grid[n][m-1] = 8
				elif(emptyU and not emptyR and not emptyL):
					inputVal = 3
					
					if (m != 0):
						grid[n][m-1] = 8
				
				grid[n][m] = inputVal
			else:
				grid[n][m]=-1
	
	for n in randi()%8+3:
		var yval = randi()%(ysize - 14) + 7
		var xval = randi()%(xsize - 14) + 7
		var num = randi()%3+4
		
		var valid = true
		
		for l in range(0, num):
			if grid[xval+l][yval]!=-1:
				valid = false
		
		if valid:
			for l in range(0, num):				
				if grid[xval+l][yval]==-1:
					if l==0 or l==num-1:
						grid[xval+l][yval]=0
					else:
						grid[xval+l][yval]=1
						
	var maxHeight = 8					
	
	for n in xsize:
		for m in ysize:
			if grid[n][m]==8 and m > 1:
				var length = 0
				for l in range(0, maxHeight):
					if m-l < 0:
						break
					elif grid[n][m-l]==-1 or grid[n][m-l]==8:
						length=length+1
					else:
						break
				
				print(length)
				
				if length > 2:
					if randi()% 30 <= 1:
						var realLength = max(3,length-randi()%6)
						for l in range(0, realLength):
							if l == 0:
								grid[n][m-l]=7
							elif l == realLength-1:
								grid[n][m-l]=5
							else:
								grid[n][m-l]=6
	
	for n in range(0,xsize - 1):
		for m in range(0, ysize-1):
			set_cell(n, m, grid[n][m])

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

extends Node2D

const N = 1
const E = 2
const S = 4
const W = 8


var cell_walls = {
	Vector2(0, -1): N, 
	Vector2(1, 0) : E, 
	Vector2(0, 1) : S,
	Vector2(-1, 0): W
	}
	
	
	
var tile_size = 64   # tile size in pixels
#var width = 16  # width of map (in tiles)  # 1080
#var height = 10 # height of map (in tiles) # 640
var width = 40  # width of map (in tiles)
var height = 24 # height of map (in tiles)

var map_seed = 0

# fraction of walls to remove
var erase_fraction = 0.2

onready var Map = $TileMap
onready var camera = $Camera2D

func _ready():
	camera.make_current()
	camera.zoom = Vector2(3.5,3.5)
	camera.position = Map.map_to_world(Vector2(width/2, height/2))
	
	randomize()  # to get random distribution
	if !map_seed:
		map_seed = randi()
	seed(map_seed)
	print("Seed: ", str(map_seed))
	tile_size = Map.cell_size
	make_maze()
	erase_walls()
	
func check_neighbors(cell, unvisited):
	# returns an array of cell's unvisited neighbors
	var list = []
	for n in cell_walls.keys():
		if cell + n in unvisited:
			list.append(cell + n)
	return list
	
	
func make_maze():
	var unvisited = []  # array of unvisited tiles
	var stack = []  # use an array as a stack
	
	# fill map with solid tiles
	Map.clear()  # clear map
	for x in range(width):
		for y in range(height):
			unvisited.append(Vector2(x, y))
			Map.set_cellv(Vector2(x,y), N|E|S|W)  # all starting tiles will be 15 - solid map, no road  (0001|0010|0100|1000 = 1111)
	var current = Vector2(0,0)
	unvisited.erase(current)
	
	while unvisited:
		var neighbors = check_neighbors(current, unvisited)  # check the neighbors of the current cell
		if neighbors.size() > 0:  # if current cell has unvisited neighbors
			var next = neighbors[randi() % neighbors.size()]  # pick a random neighbor
			stack.append(current)  # put current cell in the stack
			
			# remove walls from *both* cells
			var dir = next - current  # will return a direction vector, showing the direction between the current and the next neighbor
			var current_walls = Map.get_cellv(current) - cell_walls[dir]  # get the cell with the subtracted wall, for example if we move up we need to remove 1 to eliminate north wall)
			var next_walls = Map.get_cellv(next) - cell_walls[-dir]  # for the next cell we do the opposite to remove the south wall
			Map.set_cellv(current, current_walls)  # set map cell to match the values
			Map.set_cellv(next, next_walls)
			
			current = next  # set the next cell to be the current
			unvisited.erase(current)  # remove curent from the unvisited array
			
			# this will be done as long as there are no neighbors
		elif stack:  # if there are no neighbors
			current = stack.pop_back()  # pop a new current from the stack and back track
		
#		yield(get_tree(), 'idle_frame')  # show step by step

func erase_walls():
	# randomly remove a number of the map's walls
	for i in range(int(width * height * erase_fraction)):
		var x  = int(rand_range(1, width-1))  # pick a random tile, not an edge one
		var y = int(rand_range(1, height-1))
		var cell = Vector2(x, y)
		# pick a random neighbor of the cell
		var neighbor = cell_walls.keys()[randi() % cell_walls.size()]
		# if there is a wall between them, remove it
		if Map.get_cellv(cell) & cell_walls[neighbor]:
			var walls = Map.get_cellv(cell) - cell_walls[neighbor]
			var n_walls = Map.get_cellv(cell + neighbor) - cell_walls[-neighbor]
			Map.set_cellv(cell, walls)
			Map.set_cellv(cell + neighbor, n_walls)
		yield(get_tree(), 'idle_frame')  # show step by step
	
extends Control

export (NodePath) var node_path
onready var node = get_node(node_path)


export (PackedScene) var next_scene
var next_scene_instance = null


# Loading Thread
onready var loading_thread = Thread.new()


func _ready():
	# Begin loading data
	loading_thread.start(self, "load_data")
	
	# Display Splash screen
	splash_screen()


func splash_screen():
	print("Load splash screen")
	
	# create an instance
	next_scene_instance = next_scene.instance()
	
	# add to scene
	add_child(next_scene_instance)
	
	
func load_data(vars):
	for i in range(0, 999999):
		for j in range(0,7):
			pass
			
	print("Done loading data")
	next_scene_instance.is_loading = false  # set field to false
extends Control

# Next Scene
export (PackedScene) var next_scene

# AnimationPlayer
onready var anim_player = get_node("anim_player")	

# Wether or not we are loading
var is_loading = true


# Start
func _ready():
	# Enable user input
	set_process_input(true)
	
	# Run animation
	fade_in_out()


func _input(event):
	# if user pressed the space bar
	if(event.is_action_pressed("ui_select")):
		goto_next_scene("null")  

func fade_in_out():
	anim_player.play("fade_in_out")	
	anim_player.connect("animation_finished", self, "goto_next_scene")
	
func goto_next_scene(anim_name):
	# If animation finished but we are still loading, try to load next scene every second
	if(is_loading):
		var timer = Timer.new()
		add_child(timer)
		timer.set_wait_time(1)  # second
		timer.set_one_shot(false)  # we want it to loop
		timer.connect("timeout", self, "load_next_scene")
		timer.start()
	else:
		load_next_scene()
		
func load_next_scene():
	if(!is_loading):
		print("We are now loading the next scene from the splash screen!")
		
		# Go to next scene (add the next scene to the parent scenee as a child)
		get_parent().add_child(next_scene.instance())  
		queue_free()  # destroy this scene
	
extends Node

onready var gem = preload("res://gem.tscn")  # preload the gem scene
onready var gem_container = get_node("gem_container")  # preload the container (once)

var screensize
var level = 1
var score = 0

#func _unhandled_input(event):
#	if event is InputEventKey:
#		if event.pressed and event.scancode == KEY_ESCAPE:
#			get_tree().quit()

func _ready():
	randomize()
	screensize = get_viewport().size
	set_process(true)
	spawn_gem(10)  # spawn 10 gems
	
func _process(delta):
	if gem_container.get_child_count() == 0:
		level += 1
		spawn_gem(10 * level)

func spawn_gem(num):
	for i in range(num):
		var g = gem.instance()  # instance of a gem object
		gem_container.add_child(g)  # store it inside the container
		g.set_position(Vector2(rand_range(0, screensize.x - 40), rand_range(0, screensize.y - 40)))
		

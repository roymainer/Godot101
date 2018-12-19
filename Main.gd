extends Node

onready var gem = preload("res://gem.tscn")  # preload the gem scene
onready var gem_container = get_node("gem_container")  # preload the container (once)
onready var score_label = get_node("HUD/score_label")  # preload the score label
onready var time_label = get_node("HUD/time_label")  
onready var game_over_label = get_node("HUD/game_over_label")
onready var game_timer = get_node("game_timer")


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
	game_over_label.hide()
	
	
func _process(delta):
	time_label.set_text(str(int(game_timer.get_time_left())))
	if gem_container.get_child_count() == 0:
		level += 1
		spawn_gem(10 * level)

func spawn_gem(num):
	for i in range(num):
		var g = gem.instance()  # instance of a gem object
		gem_container.add_child(g)  # store it inside the container
		g.connect("gem_grabbed", self, "_on_gem_grabbed")
		var g_extents = g.get_node("sprite").get_texture().get_size() /2 
		g.set_position(Vector2(rand_range(g_extents.x, screensize.x - g_extents.x), rand_range(g_extents.y, screensize.y - g_extents.y)))
		
func _on_gem_grabbed():
	score += 10
	score_label.set_text(str(score))
#	print(score)

func _on_game_timer_timeout():
	get_node("player").set_physics_process(false)
	game_over_label.show()
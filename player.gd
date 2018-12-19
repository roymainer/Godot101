extends Area2D
 
export var speed = 400
 
var velocity = Vector2()
var screen_size = Vector2()
var extents = Vector2()
 
func _ready():
#    set_physics_process(true)  # not needed anymore
	screen_size = get_viewport_rect().size
	extents = get_node("sprite").get_texture().get_size() / 3
	position = screen_size / 2
	print(position)
   
func _physics_process(delta):
	velocity = Vector2()
	
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
	
	if Input.is_action_pressed('ui_right'):
    	velocity.x = speed
	if Input.is_action_pressed('ui_left'):
    	velocity.x = - speed
	if Input.is_action_pressed('ui_up'):
    	velocity.y = -speed
	if Input.is_action_pressed('ui_down'):
    	velocity.y = speed
   
	var pos = get_position() + velocity * delta
   
	pos.x = clamp(pos.x, extents.x, screen_size.x - extents.x)  # clamp limits the values to the player borders
	pos.y = clamp(pos.y, extents.y, screen_size.y - extents.y/2)
	set_position(pos)
extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var screensize
var extents
var pos
#var velocity = Vector2(200,100)  # constant
var velocity # non constant
var spin  # rotation speed

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	randomize()  # get different random values for each run
#	print(get_position())
	screensize = get_viewport_rect().size
	extents = get_texture().get_size() / 2  # cause pos.x is the sprites center
	pos = screensize /2
	velocity = Vector2(rand_range(100, 300), 0).rotated(rand_range(0, 2*PI))  # anytime we play the velocity will change it's vector
	spin = rand_range(-PI, PI)
	set_process(true)

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	set_rotation(get_rotation() + spin * delta)
	pos = pos + velocity * delta
	if pos.x >= screensize.x - extents.x:
		pos.x = screensize.x - extents.x  # to avoid passing the border
		velocity.x *= -1
	if pos.x <= extents.x:
		pos.x = extents.x
		velocity.x *= -1
	if pos.y >= screensize.y - extents.y:
		pos.y = screensize.y - extents.y
		velocity.y *= -1
	if pos.y <= extents.y:
		pos.y = extents.y
		velocity.y *= -1
	set_position(pos)

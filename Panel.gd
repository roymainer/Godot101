tool

extends Panel

export (int) var rotation = 0 setget set_rotation


func _ready():
	# Get property
	var size = get("rect_size")
	print(size)
	
	
func set_rotation(value):
	rotation = value
	set("rect_rotation", value)
	
extends Area2D

func _ready():
	pass

func _on_gem_area_entered(area):
	print(area.get_name())  # print what area overlaps
	if area.get_name() == "player":
		queue_free()  # delete the node at the end of the frame

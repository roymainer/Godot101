extends Area2D

onready var fadeout_effect = get_node("fadeout_effect")
#onready var fadein_effect = get_node("fadein_effect")
onready var sprite = get_node("sprite")

signal gem_grabbed

func _ready():
	fadeout_effect.interpolate_property(sprite, 
								"scale", 
								sprite.get_scale(), 
								Vector2(2.0, 2.0), 
								0.3, 
								Tween.TRANS_QUAD, 
								Tween.EASE_OUT)
	fadeout_effect.interpolate_property(sprite, 
								"modulate", 
								Color(1,1,1,1), 
								Color(1,1,1,0), 
								0.3, 
								Tween.TRANS_QUAD, 
								Tween.EASE_OUT)
								
#	fadein_effect.interpolate_property(sprite, "scale", Vector2(0,0), Vector2(1,1), 0.3, Tween.TRANS_QUAD, Tween.EASE_IN)
#	fadein_effect.interpolate_property(sprite, "modulate", Color(1,1,1,0), Color(1,1,1,1), 0.3, Tween.TRANS_QUAD, Tween.EASE_IN)
#
#	fadein_effect.start()
#	fadein_effect.set_repeat(false)

func _on_gem_area_entered(area):
#	print(area.get_name())  # print what area overlaps
	if area.get_name() == "player":
		emit_signal("gem_grabbed")
		
		# get rid of the touched gem object so the player can't double touch for extra score
		var owners = get_shape_owners()
		shape_owner_clear_shapes(owners[0]) 
		fadeout_effect.start()  # start the tween effect
		

func _on_effect_tween_completed(object, key):
	queue_free()  # delete the node when the tween completes

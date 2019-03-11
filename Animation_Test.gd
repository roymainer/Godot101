extends Control

# Connect the node to our animation player signals, replaces get node in code
onready var anim_player = get_node("Anim_Player")  

enum ANIM_STATE {
	WALK,
	CLIMB
	}

var anim_state = null

func _ready():
	print("Ready function")
#	# Connect the node to our animation player signals
	anim_player.connect("animation_finished", self, "on_anim_finished")
	
	# set initial walk animation
	anim_state = ANIM_STATE.WALK
	anim_player.play("walk")

func on_anim_finished(anim_name):
	print(anim_name)
	if (anim_state == ANIM_STATE.WALK):
		anim_state = ANIM_STATE.CLIMB
		anim_player.play("climb")
	else:
		anim_state = ANIM_STATE.WALK
		anim_player.play("walk")
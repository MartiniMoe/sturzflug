extends Area2D

var pill_taken
var player

func _fixed_process(delta):
	if not get_overlapping_bodies().empty():
		for body in get_overlapping_bodies():
			if not pill_taken and body.is_in_group("player"):
				body.show_hint("Take a pill")
				if(not pill_taken and Input.is_action_pressed("use")):
					pill_taken=true
					if randi()%3!=0:
						player.alter_madness_mod(-1)
					else:
						player.alter_madness_mod(1)

func _ready():
	pill_taken=false
	player=get_node("/root/World/Player")
	set_fixed_process(true)

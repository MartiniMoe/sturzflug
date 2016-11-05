extends Area2D

var funk_send

func _fixed_process(delta):
	if not get_overlapping_bodies().empty():
		for body in get_overlapping_bodies():
			if not playing and body.is_in_group("player"):
				body.show_hint("Send out important data")
				if(Input.is_action_just_pressed("use")):
					funk_send=true

func _ready():
	funk_send=false
	set_fixed_process(true)

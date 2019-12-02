extends Area2D

var funk_send

func _fixed_process(delta):
	if not get_overlapping_bodies().empty():
		for body in get_overlapping_bodies():
			if not funk_send and body.is_in_group("player"):
				body.show_hint("Send out important data")
				if(not funk_send and Input.is_action_pressed("use")):
					funk_send=true
					#get_node("/root/World").score += 200
					get_node("/root/World/Player").add_to_score(200)

func _ready():
	funk_send=false
	set_fixed_process(true)

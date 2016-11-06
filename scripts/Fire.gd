extends Area2D

var burning

func _fixed_process(delta):
	if not get_overlapping_bodies().empty():
		for body in get_overlapping_bodies():
			if burning and body.is_in_group("player"):
				body.show_hint("Extinguish fire")
				if(Input.is_action_just_pressed("use")):
					burning=false
					get_node("/root/World/Player").add_to_score(200)
					free()
					
func _ready():
	burning=true
	set_fixed_process(true)

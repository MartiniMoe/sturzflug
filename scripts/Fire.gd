extends Area2D

var burning

func _fixed_process(delta):
	if !burning && get_node("Timer").get_time_left() <= 0:
		queue_free()
	if not get_overlapping_bodies().empty():
		for body in get_overlapping_bodies():
			if burning and body.is_in_group("player"):
				body.show_hint("Extinguish fire")
				if(burning and Input.is_action_pressed("use")):
					burning=false
					get_node("/root/World/Player").add_to_score(200)
					get_node("FireParticles3").set_emitting(false)
					get_node("FireParticles2").set_emitting(false)
					get_node("FireParticles").set_emitting(false)
					get_node("Timer").start()
					
func _ready():
	burning=true
	set_fixed_process(true)

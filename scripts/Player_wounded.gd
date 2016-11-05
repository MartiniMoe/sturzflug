extends Node2D


var alive = true


func _fixed_process(delta):
	if not get_node("TorsoArea").get_overlapping_bodies().empty():
		for body in get_node("TorsoArea").get_overlapping_bodies():
			if body.is_in_group("player"):
				body.show_hint("Use to redeem")
				if(alive and Input.is_action_just_pressed("ui_accept")):
					die()


func die():
	alive = false
	get_node("AnimationPlayer").play("die")
	get_node("TorsoArea/Particles2D").set_emitting(false)


func _ready():
	set_fixed_process(true)
	get_node("AnimationPlayer").play("idle")
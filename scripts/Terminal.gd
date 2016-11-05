extends Area2D

var alarm


func _fixed_process(delta):
	if not get_overlapping_bodies().empty():
		for body in get_overlapping_bodies():
			if alarm.active and body.is_in_group("player"):
				body.show_hint("Use to deactivate alarm")
				if(alarm.active and Input.is_action_just_pressed("use")):
					alarm.stop_alarm()


func _ready():
	alarm=get_parent().get_node("Alarm")
	set_fixed_process(true)

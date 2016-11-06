extends Area2D

var alarms
var alarm_player
var active

func _fixed_process(delta):
	if not get_overlapping_bodies().empty():
		for body in get_overlapping_bodies():
			if active and body.is_in_group("player"):
				body.show_hint("Use to deactivate alarm")
				if Input.is_action_just_pressed("use"):
					for alarm in alarms:
						alarm.stop_alarm()
						alarm_player.stop_all()
					get_node("/root/World/Player").alter_madness_mod(-1)
					active=false


func _ready():
	#get_node("/root/World/Player").alter_madness_mod(+1)
	active=true
	alarms=get_tree().get_nodes_in_group("alarm")
	alarm_player=get_node("Alarm_Player")
	alarm_player.play("alarm")
	set_fixed_process(true)

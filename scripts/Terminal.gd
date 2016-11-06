extends Area2D

var alarms
var alarm_player
var active
var time

func _fixed_process(delta):
	time+=delta
	if active:
		if not get_overlapping_bodies().empty():
			for body in get_overlapping_bodies():
				if body.is_in_group("player"):
					body.show_hint("Use to deactivate alarm")
					if Input.is_action_just_pressed("use"):
						for alarm in alarms:
							alarm.stop_alarm()
						alarm_player.stop_all()
						get_node("/root/World/Player").alter_madness_mod(-1)
						active=false
						time=0
	elif time >= 30+randf()*10:
		for alarm in alarms:
			alarm.start_alarm()
		alarm_player.play("alarm")
		active=true
		get_node("/root/World/Player").alter_madness_mod(1)


func _ready():
	get_node("/root/World/Player").alter_madness_mod(1)
	active=true
	time=0
	alarms=get_tree().get_nodes_in_group("alarm")
	alarm_player=get_node("Alarm_Player")
	alarm_player.play("alarm")
	set_fixed_process(true)
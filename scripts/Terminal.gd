extends Area2D

var alarm

func _fixed_process(delta):
	if not get_overlapping_bodies().empty():
		#print("something inside")
		if(alarm.active and Input.is_action_just_pressed("ui_accept")):
			print("button pressed")
			alarm.stop_alarm()

func _ready():
	alarm=get_parent().get_node("Alarm")
	set_fixed_process(true)
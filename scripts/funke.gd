extends Area2D

var funk_send

func _fixed_process(delta):
	if not get_overlapping_bodies().empty():
		if(Input.is_action_just_pressed("use")):
			funk_send=true

func _ready():
	funk_send=false
	set_fixed_process(true)

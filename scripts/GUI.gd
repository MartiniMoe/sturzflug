extends Control


func _fixed_process(delta):
	#set madness_mod
	var mad_mod = get_node("/root/World/Player").madness_mod
	var mad = get_node("/root/World/Player").madness
	if mad_mod > 3:
		mad_mod = 3
	elif mad_mod < -3:
		mad_mod = -3
	get_node("VBoxContainer/Madsess_Mod").set_frame(mad_mod+3)
	get_node("VBoxContainer/Madness").set_val(mad)


func _ready():
	set_fixed_process(true)
	get_node("VBoxContainer").set_pos(Vector2(-900, -500))
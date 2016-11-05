extends Control


func _fixed_process(delta):
	#set madness_mod
	var mad_mod = get_node("/root/World/Player").madness_mod
	var mad = get_node("/root/World/Player").madness
	get_node("VBoxContainer/Madsess_Mod").set_frame(mad_mod+3)
	get_node("VBoxContainer/Madness").set_val(mad)


func _ready():
	set_fixed_process(true)
	var screen_width = get_viewport_rect().size.x
	var screen_height = get_viewport_rect().size.y
	get_node("VBoxContainer").set_pos(Vector2(screen_width/-1.3, screen_height/-1.3))
extends Control


func _fixed_process(delta):
	#set_global_pos(Vector2(0, 0))
	pass


func _ready():
	set_fixed_process(true)
	var screen_width = get_viewport_rect().size.x
	var screen_height = get_viewport_rect().size.y
	get_node("VBoxContainer").set_pos(Vector2(screen_width/-1.3, screen_height/-1.3))
extends Node2D

var falling_vector = Vector2(-1, -0.4)

func _fixed_process(delta):
	var current_bg_pos = get_node("ParallaxBackground").get_scroll_base_offset()
	current_bg_pos += (falling_vector * 500 * delta)
	get_node("ParallaxBackground").set_scroll_base_offset(current_bg_pos)
	
	# shake dat cam.
	get_node("Camera2D").set_rot(rand_range(-0.005, 0.005))
	
	# rotate falling vector
	falling_vector = falling_vector.rotated(-0.005 * delta)
	get_node("Ship").set_rot(falling_vector.angle() + 0.62 * PI)


func _ready():
	set_fixed_process(true)
extends Node2D

var falling_vector = Vector2(-1, -0.4)
var playtime = 0
var total_time_to_crash = 10
var planet_texture = preload("res://sprites/planet.png")

func _fixed_process(delta):
	playtime += delta
	#if playtime > total_time_to_crash:
	#	var planet = Sprite.new()
	#	planet.set_texture(planet_texture)
	#	planet.set_z(-2)
	#	planet.set_pos(Vector2(400, 1000))
	#	add_child(planet)
	
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
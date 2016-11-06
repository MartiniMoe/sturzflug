extends Node2D

var falling_vector = Vector2(-1, -0.4)
var playtime = 0
var total_time_to_crash = 60
var planet_texture = preload("res://sprites/planet-small.png")
var game_over = false

func _fixed_process(delta):
	playtime += delta
	if playtime > total_time_to_crash:
		Transition.fade_to("res://scenes/Crash.tscn")
		game_over = true
		playtime = 0
	
	if !game_over:
		scale_planet()
	
	var current_bg_pos = get_node("ParallaxBackground").get_scroll_base_offset()
	current_bg_pos += (falling_vector * 500 * delta)
	get_node("ParallaxBackground").set_scroll_base_offset(current_bg_pos)
	
	# shake dat cam.
	var shake = rand_range(-0.005, 0.005)
	get_node("Camera2D").set_rot(shake)
	get_node("Planet").set_rot(-shake)
	
	# rotate falling vector
	falling_vector = falling_vector.rotated(-0.003 * delta)
	get_node("Ship").set_rot(falling_vector.angle() + 0.62 * PI)


func scale_planet():
	var planet = get_node("Planet")
	var scale_fac = (playtime*playtime)/(10*total_time_to_crash)
	var scale = Vector2(1 + scale_fac, 1 + scale_fac)
	planet.set_scale(scale)
	var y_pos = planet.get_pos().y + playtime/(200*total_time_to_crash)
	#planet.set_pos(Vector2(planet.get_pos().x, y_pos))


func _ready():
	var planet = Sprite.new()
	set_fixed_process(true)
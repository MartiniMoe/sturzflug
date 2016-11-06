extends Node2D

var exploded = false

func _fixed_process(delta):
	if !exploded && get_node("Planet").get_overlapping_bodies().empty():
		#get_node("Ship").set_pos(get_node("Ship").get_pos() + Vector2(500*delta, 0))
		get_node("Ship").apply_impulse(Vector2(0, 0), (get_node("Planet").get_pos() - get_pos()).normalized() * 2)
	elif !exploded:
		exploded = true
		get_node("Ship").hide()
		get_node("AnimationPlayer").play("explosion")

func _ready():
	#get_node("StreamPlayer").seek_pos(26)
	get_node("StreamPlayer").set_stream(load("res://sounds/crash.ogg"))
	get_node("StreamPlayer").play(16.2)
	get_node("Score").set_text("Score: " + str(gamestate.score))
	set_fixed_process(true)
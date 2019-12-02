extends KinematicBody2D

const GRAVITY_VEC = Vector2(0,900)
const FLOOR_NORMAL = Vector2(0,-1)
const SLOPE_SLIDE_STOP = 25.0
const MIN_ONAIR_TIME = 0.1
const WALK_SPEED = 250 # pixels/sec
const JUMP_SPEED = 480
const SIDING_CHANGE_SPEED = 10

var linear_vel = Vector2()
var onair_time = 0 # 
var on_floor = false

var anim
var madness_mod = 2

var player_state = STATE_IDLE
const STATE_IDLE = 0
const STATE_WALKING = 1
const STATE_JUMPING = 2


func _fixed_process(delta):
	if get_node("Hint_timer").get_time_left() <= 0.0:
		get_node("Hint_timer").stop()
		get_node("Hint").hide()
	
	if gamestate.madness > 100:
		lose_to_madness()
	
	#increment counters
	onair_time+=delta
	
	movement(delta)
	handle_madness(delta)
	animate()


func in_lift():
	for body in get_parent().get_node("Ship/Ship_Cockpit/Lifts").get_overlapping_bodies():
		if body.is_in_group("player"):
			return true
	return false


func lose_to_madness():
	print("lose to madness")
	gamestate.madness = 0
	Transition.fade_to("res://scenes/gameover_madness.tscn")


func handle_madness(delta):
	gamestate.madness += madness_mod * delta


func add_to_score(scoreadd):
	#score += scoreadd
	gamestate.score += scoreadd
	get_node("Event").show_event(str(scoreadd) + " score!")


func alter_madness_mod(madness_mod_mod):
	if madness_mod_mod > 0 && madness_mod < 3:
		madness_mod += madness_mod_mod
		get_node("Event").show_event(str(madness_mod_mod) + " madness!")
	elif madness_mod_mod < 0 && madness_mod > -3:
		madness_mod += madness_mod_mod
		get_node("Event").show_event(str(madness_mod_mod) + " madness!")


func movement(delta):
	# Apply Gravity
	if !in_lift():
		linear_vel += delta * GRAVITY_VEC
	# Move and Slide
	var scale = get_scale()
	linear_vel = move_and_slide( linear_vel, FLOOR_NORMAL, SLOPE_SLIDE_STOP )
	set_scale(scale)
	# Detect Floor
	if (is_move_and_slide_on_floor()):
		onair_time=0
	
	on_floor = onair_time < MIN_ONAIR_TIME
	
	# Horizontal Movement
	var target_speed = 0
	if (Input.is_action_pressed("move_left")):
		target_speed += -1
		set_scale(Vector2(-1, 1))
		get_node("Hint").set_scale(Vector2(-1, 1))
		get_node("Event").set_scale(Vector2(-1, 1))
		player_state = STATE_WALKING
	elif (Input.is_action_pressed("move_right")):
		target_speed +=  1
		set_scale(Vector2(1, 1))
		get_node("Hint").set_scale(Vector2(1, 1))
		get_node("Event").set_scale(Vector2(1, 1))
		player_state = STATE_WALKING
	else:
		player_state = STATE_IDLE
	if (on_floor and Input.is_action_pressed("jump")):
		linear_vel.y=-JUMP_SPEED
		player_state = STATE_JUMPING
	
	target_speed *= WALK_SPEED
	linear_vel.x = lerp( linear_vel.x, target_speed, 0.1 )


func animate():
	var current_anim = anim.get_current_animation()
	if player_state == STATE_IDLE && current_anim != "idle" && on_floor:
		anim.play("idle")
	elif player_state == STATE_WALKING && current_anim != "walk":
		anim.play("walk")
	elif player_state == STATE_JUMPING && current_anim != "jump":
		anim.play("jump")


func show_hint(hinttext):
	var hint = get_node("Hint")
	var hint_timer = get_node("Hint_timer")
	if !hint.is_visible():
		hint_timer.start()
		hint.set_text(hinttext)
		hint.show()


func _ready():
	anim = get_node("AnimationPlayer")
	anim.set_speed(3.0)
	anim.play("idle")
	set_fixed_process(true)

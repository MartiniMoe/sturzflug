extends KinematicBody2D

const GRAVITY_VEC = Vector2(0,900)
const FLOOR_NORMAL = Vector2(0,-1)
const SLOPE_SLIDE_STOP = 25.0
const MIN_ONAIR_TIME = 0.1
const WALK_SPEED = 250 # pixels/sec
const JUMP_SPEED = 280
const SIDING_CHANGE_SPEED = 10

var linear_vel = Vector2()
var onair_time = 0 # 
var on_floor = false

var anim


func _fixed_process(delta):
	#increment counters
	onair_time+=delta
	
	movement(delta)


func movement(delta):
	# Apply Gravity
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
		if !anim.is_playing() || anim.get_current_animation() != "walk":
			anim.play("walk")
	elif (Input.is_action_pressed("move_right")):
		target_speed +=  1
		set_scale(Vector2(1, 1))
		if !anim.is_playing() || anim.get_current_animation() != "walk":
			anim.play("walk")
	else:
		if !anim.is_playing() || anim.get_current_animation() != "idle":
			anim.play("idle")
	
	target_speed *= WALK_SPEED
	linear_vel.x = lerp( linear_vel.x, target_speed, 0.1 )
	
	# Jumping
	if (on_floor and Input.is_action_just_pressed("jump")):
		linear_vel.y=-JUMP_SPEED


func _ready():
	anim = get_node("AnimationPlayer")
	anim.set_speed(3.0)
	anim.play("idle")
	set_fixed_process(true)
extends Particles2D


func _fixed_process(delta):
	var falling_dir = get_node("/root/World").falling_vector
	set_param(0, rad2deg(falling_dir.angle()))


func _ready():
	set_fixed_process(true)
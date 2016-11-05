extends Camera2D


func _fixed_process(delta):
	#set to player pos
	var player_pos = get_node("../Player").get_pos()
	set_pos(player_pos)


func _ready():
	set_fixed_process(true)
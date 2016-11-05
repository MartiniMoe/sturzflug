extends AnimatedSprite

var active
var alarm_player

func _ready():
	active=true
	get_node("/root/World/Player").madness_mod+=1
	alarm_player=get_node("Alarm_Player")
	alarm_player.play("alarm")
	
func stop_alarm():
	active=false
	get_node("/root/World/Player").madness_mod-=1
	stop()
	set_frame(0)
	alarm_player.stop_all()
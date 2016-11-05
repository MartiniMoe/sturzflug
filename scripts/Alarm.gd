extends AnimatedSprite

var active

func _ready():
	active=true
	get_node("/root/World/Player").madness_mod+=1
	
func stop_alarm():
	active=false
	get_node("/root/World/Player").madness_mod-=1
	stop()
	set_frame(0)
	get_node("Alarm_Player").stop_all()
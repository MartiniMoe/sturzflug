extends Sprite

var active
var alarm_player

func _ready():
	active=true
	get_node("/root/World/Player").madness_mod+=1
	alarm_player=get_node("Alarm_Player")
	alarm_player.play("alarm")
	get_node("alarm_blink_player").play("alarm_blink")
	
func stop_alarm():
	active=false
	#get_node("/root/World/Player").madness_mod-=1
	get_node("/root/World/Player").alter_madness_mod(-1)
	
	get_node("alarm_blink_player").stop_all()
	get_node("alarm_blink_player").seek(0.5,true)
	alarm_player.stop_all()
extends Sprite

var alarm_player

func _ready():
	alarm_player=get_node("alarm_blink_player")
	alarm_player.play("alarm_blink")

func stop_alarm():
	alarm_player.stop_all()
	alarm_player.seek(0.5,true)
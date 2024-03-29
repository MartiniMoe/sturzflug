extends Area2D

var music_played

var playing

var title_list=["grind.ogg", "ambient1.ogg", "ambient2.ogg"]
var title_good=[false,true,true]
var title_objects
var music_player
var player

func _fixed_process(delta):
	if not get_overlapping_bodies().empty():
		for body in get_overlapping_bodies():
			if not playing and body.is_in_group("player"):
				body.show_hint("Play some music")
				var ind=randi()%title_list.size()
				var title=title_list[ind]
				var good=title_good[ind]
				if(not playing and Input.is_action_pressed("use")):
					music_player.set_stream(title_objects[ind])
					music_player.play()
					if good:
						#player.madness_mod-=1
						player.alter_madness_mod(-1)
					else:
						#player.madness_mod+=1
						player.alter_madness_mod(1)
					playing=true

func _ready():
	music_player=get_node("music_player")
	player=get_node("/root/World/Player")
	title_objects=[]
	for title in title_list:
		title_objects.append(load("res://sounds/" + title))
	playing=false
	set_fixed_process(true)
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
		ind=randi()%title_list.len()
		title=title_list[ind]
		good=title_good[ind]
		if(not playing and Input.is_action_just_pressed("use")):
			music_player.set_stream(title_objects[ind])
			music_player.play()
			if good:
				player.madness_mod-=1
			else:
				player.madness_mod+=1
			playing=true

func _ready():
	music_player=get_node("music_player")
	player=get_node("/root/World/Player")
	title_objects=[]
	for title in title_list:
		title_objects.append(load(title))
	playing=false
	set_fixed_process(true)
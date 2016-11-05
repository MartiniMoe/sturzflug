extends Area2D

var music_played

var playing

var title_list=["foo","bar","baz"]
var title_good=[true,false,false]

func _fixed_process(delta):
	if not get_overlapping_bodies().empty():
		ind=randi()%title_list.len()
		title=title_list[ind]
		good=title_good[ind]
		if(not playing and Input.is_action_just_pressed("ui_accept")):
			get_node("music_player").play(title)
			if good:
				get_node("/root/World/Player").madness_mod-=1
			else:
				get_node("/root/World/Player").madness_mod+=1
			playing=true

func _ready():
	playing=false
	set_fixed_process(true)
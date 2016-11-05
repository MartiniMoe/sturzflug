extends Label

var display_time = 1.5
var display_timer = 0


func _fixed_process(delta):
	if is_visible():
		display_timer += delta
		if get_scale().x > 0:
			set_scale(Vector2(1 + 1 * display_timer, 1 + 1 * display_timer))
		elif get_scale().x < 0:
			set_scale(Vector2(-1 - 1 * display_timer, 1 + 1 * display_timer))
		set_opacity(1 - 1 * display_timer)
		if display_timer > display_time:
			hide()
			set_scale(Vector2(1, 1))
			set_opacity(1)
			display_timer = 0


func show_event(string):
	show()
	set_text(string)


func _ready():
	set_fixed_process(true)
	hide()
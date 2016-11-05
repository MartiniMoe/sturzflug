extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	get_node("Label").set_text("Game over!\nYou've become mad!\nYour score is " + str(gamestate.score) + ".")
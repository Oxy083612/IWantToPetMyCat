extends Control

@onready var points_label = $ColorRect/BoxContainer/GridContainer/Points
@onready var ending_label = $ColorRect/BoxContainer/GridContainer/Ending

func _ready() -> void:
	points_label.text = "Your score: " + str(Points.points)
	if Points.points < 0:
		ending_label.text = "You are a terrible person."
	elif Points.points == 0:
		ending_label.text = "The cat fleed. Don't worry, you'll pet it the next time!"
	else:
		ending_label.text = "The cat is reeeaaallyyy happy :3"


func _on_menu_pressed() -> void:
	Equipment.reset()
	Hand.reset()
	Hand.show()
	Music.stop()
	get_tree().change_scene_to_file("res://scenes/menu/menu.tscn")

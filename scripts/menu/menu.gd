extends Control

func _ready():
	Music.stream.loop = true
	#Music.play() # TODO: uncomment to make music work

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/item_gathering/gathering_scene.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()

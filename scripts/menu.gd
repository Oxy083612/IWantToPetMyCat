extends Control

func _ready():
	Music.autoplay = true
	Music.stream.loop = true
	print(Music.stream.loop)

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/cutscene.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()

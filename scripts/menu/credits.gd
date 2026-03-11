extends Control


func _on_return_pressed() -> void:
	ButtonSound.play()
	Points.points = 0
	get_tree().change_scene_to_file("res://scenes/menu/menu.tscn")

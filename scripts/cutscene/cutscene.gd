extends Node2D

func _ready():
	Music.stop()
	$VideoStreamPlayer.play()

func _on_video_stream_player_finished() -> void:
	$VideoStreamPlayer.stop()
	get_tree().change_scene_to_file("res://scenes/menu/menu.tscn")			


func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed:
			$VideoStreamPlayer.stop()
			get_tree().change_scene_to_file("res://scenes/menu/menu.tscn")	

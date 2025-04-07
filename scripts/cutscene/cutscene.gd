extends Node2D

func _ready():
	$VideoStreamPlayer.play()

func _on_video_stream_player_finished() -> void:
	$VideoStreamPlayer.stop()
	Music.play()
	get_tree().change_scene_to_file("res://sceny/search_items_level.tscn")

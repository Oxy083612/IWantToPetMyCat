extends Control


@onready var audio_label = $Audio/Label
@onready var is_audio_muted = false
@onready var master_bus_idx = AudioServer.get_bus_index("Master")


func _ready():
	Music.stream.loop = true
	if not Music.playing:
		Music.play()

func _on_play_pressed() -> void:
	ButtonSound.play()
	get_tree().change_scene_to_file("res://scenes/item_gathering/gathering_scene.tscn")

func _on_credits_pressed() -> void:
	ButtonSound.play()
	get_tree().change_scene_to_file("res://scenes/menu/credits.tscn")


func _on_audio_pressed() -> void:
	ButtonSound.play()
	if is_audio_muted:
		is_audio_muted = false
		audio_label.text = "AUDIO ON"
		AudioServer.set_bus_mute(master_bus_idx, false)
		Music.play()
		return
	is_audio_muted = true
	audio_label.text = "AUDIO OFF"
	AudioServer.set_bus_mute(master_bus_idx, true)
	Music.stop()
		

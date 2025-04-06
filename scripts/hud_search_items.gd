extends CanvasLayer

@onready var timer: Timer = $Timer
@onready var bar: TextureProgressBar = $Bar/TextureProgressBar

const max_time = 60

func _ready() -> void:
	timer.start(max_time)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var progress = timer.time_left / max_time * 100  # TODO: update after bar texture change
	bar.set_value(progress)

func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/build_hand_level.tscn")

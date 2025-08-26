extends CanvasLayer

@onready var timer: Timer = $Timer
@onready var bar: TextureProgressBar = $Bar/TextureProgressBar

const max_time = 60 # original value
#const max_time = 500 # value used for debug

func _ready() -> void:
	timer.start(max_time)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	var progress = timer.time_left / max_time * 100
	bar.set_value(progress)

func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/hand_building/building_scene.tscn")

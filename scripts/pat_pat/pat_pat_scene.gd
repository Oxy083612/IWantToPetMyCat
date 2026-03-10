extends Node2D

@onready var mouse_pressed = false
@onready var mouse_in_circle = false
@onready var last_mouse_position = Vector2(0, 0)
@onready var purr_stream = $AudioStreamPlayer2D
@onready var purring = false
@onready var cat = $Sprite2D
@onready var hand_angle = 315

func _ready() -> void:
	var cat_position = cat.global_position
	var hand_length = Hand.targetPosition - Hand.global_position
	var length_vector = Vector2(hand_length.x, 0)
	length_vector = length_vector.rotated(deg_to_rad(hand_angle))
	Hand.global_rotation = deg_to_rad(hand_angle)
	Hand.global_position = cat_position - length_vector

func _input(event) -> void:
	if event is not InputEventMouseButton:
		return
	if event.button_index != MOUSE_BUTTON_LEFT :
		return
	mouse_pressed = event.pressed
	
func _on_area_2d_mouse_entered() -> void:
	mouse_in_circle = true

func _on_area_2d_mouse_exited() -> void:
	mouse_in_circle = false

func can_be_petted(current_mouse_position: Vector2) -> bool:
	if current_mouse_position.distance_to(last_mouse_position) < 1:
		return false
	return mouse_pressed and mouse_in_circle

func _physics_process(delta: float) -> void:
	var current_mouse_position = get_viewport().get_mouse_position()
	if can_be_petted(current_mouse_position):
		if not purring:
			print("meow")
			print("mouse", current_mouse_position)
			print("target", Hand.targetPosition)
			print("last", Hand.lastPosition)
			print("global", Hand.global_position)
			purring = true
			purr_stream.play()
	else:
		purring = false
		purr_stream.stop()
	last_mouse_position = current_mouse_position


func _on_audio_stream_player_2d_finished() -> void:
	if purring:
		purr_stream.play()

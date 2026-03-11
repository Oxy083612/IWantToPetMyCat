extends Node2D

@onready var mouse_pressed = false
@onready var mouse_in_circle = false
@onready var last_mouse_position = Vector2(0, 0)
@onready var purr_stream = $AudioStreamPlayer
@onready var purring = false
@onready var cat_position = $Sprite2D.global_position
@onready var cat_radius = $Sprite2D/Area2D/CollisionShape2D.shape.radius * 5
@onready var hand_angle = 330.0
@onready var hand_default = Hand.global_position
@onready var angle_speed = 2.0
@onready var current_angle = 0.0
@onready var bar = $Bar/TextureProgressBar
@onready var points_label = $Label
@onready var finish_button = $Finish
@onready var petting_finished = false
@onready var tip = $Tip/Label

func _ready() -> void:
	Points.points = 0
	var hand_length = Hand.targetPosition - Hand.global_position
	var length_vector = Vector2(hand_length.x, 0.0)
	length_vector = length_vector.rotated(deg_to_rad(hand_angle))
	Hand.global_rotation = deg_to_rad(hand_angle)
	var radius_vector = Vector2(0, cat_radius)
	radius_vector = radius_vector
	Hand.global_position = cat_position - length_vector
	hand_default = Hand.global_position
	Hand.global_position += Vector2(cat_radius, 0.0)
	if Hand.length == 0:
		finish_petting()	
	

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
	if petting_finished:
		return false
	return mouse_pressed and mouse_in_circle

func finish_petting():
	petting_finished = true
	bar.hide()
	Hand.hide()
	tip.hide()
	finish_button.show()

func _physics_process(delta: float) -> void:
	var current_mouse_position = get_viewport().get_mouse_position()
	if can_be_petted(current_mouse_position):
		current_angle += delta * angle_speed
		var x_increment = cat_radius * cos(current_angle)
		var y_increment = cat_radius * sin(current_angle)
		var increment = Vector2(x_increment, y_increment)
		Hand.global_position = hand_default + increment
		var durability_factor = 0
		if Hand.durability !=  0:
			durability_factor = pow(Hand.length, 1.5) / float(Hand.durability * 6)
		bar.value += durability_factor
		Points.points += Hand.quality
		points_label.text = "Points: " + str(Points.points)
		if not purring:
			purring = true
			purr_stream.play()
		if bar.value >= 100:
			finish_petting()
	else:
		purring = false
		purr_stream.stop()
	last_mouse_position = current_mouse_position


func _on_audio_stream_player_2d_finished() -> void:
	if purring:
		purr_stream.play()


func _on_finish_pressed() -> void:
	ButtonSound.play()
	get_tree().change_scene_to_file("res://scenes/pat_pat/ending.tscn")

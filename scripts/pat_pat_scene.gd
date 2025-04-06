extends Node2D

var rng = RandomNumberGenerator.new()
@onready var cat_anger: Sprite2D = $"Cat anger"
@onready var cat_happy: Sprite2D = $"Cat happy"
@onready var not_long_enough: Sprite2D = $"Not long enough"
@onready var awwww: Sprite2D = $Awwww


func _input(event):
	if event.is_action_pressed("quit"):
		get_tree().quit()

func finish():
	if Hand.length < GameLoop.min_length:
		not_long_enough.visible = true
	elif Hand.durability < GameLoop.min_durability:
		var destroy_chance = int((GameLoop.min_durability - Hand.durability) * 100 / GameLoop.min_durability)
		var choice = rng.randi_range(0, 100)
		if choice < destroy_chance:
			cat_anger.visible = true
		else:
			awwww.visible = true
			cat_happy.visible = true
	else:
		awwww.visible = true
		cat_happy.visible = true
	
func _on_texture_button_pressed() -> void:
	finish()

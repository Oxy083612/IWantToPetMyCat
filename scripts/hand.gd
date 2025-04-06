extends Node2D

var length = 0
var durability = 0
var real_durability = 0
var current_length = 0
var current_items = []

@onready var item_length_1: PackedScene = preload("res://scenes/item_length_1.tscn")
@onready var item_length_2: PackedScene = preload("res://scenes/item_length_2.tscn")
@onready var item_slot: PackedScene = preload("res://scenes/item_slot.tscn")

var lastPosition
var targetPosition

func _ready():
	global_position.x = 128
	global_position.y = 564
	lastPosition = global_position
	targetPosition = global_position
	
func draw_stick():
	for item_name in current_items:
		if(Equipment._return_length(item_name) == 1):
			var item_big = item_length_1.instantiate()
			Hand.add_child(item_big)
			item_big.get_node("Sprite2D").texture = load(Equipment._return_texture_big_name(item_name))
			item_big.position = targetPosition
			var sprite_tape = Sprite2D.new()
			sprite_tape.scale = Vector2(0.5, 0.5)
			sprite_tape.rotation_degrees = randi_range(70, 110)
			sprite_tape.texture = load("res://images/items/big/short_tape.png")
			item_big.add_child(sprite_tape)
			if targetPosition == Hand.global_position:
				sprite_tape.position = targetPosition
			targetPosition = item_big.get_node("end").global_position
			lastPosition = item_big.get_node("start").global_position
			current_length += 1
		else:
			var item_big = item_length_2.instantiate()
			Hand.add_child(item_big)
			item_big.get_node("Sprite2D").texture = load(Equipment._return_texture_big_name(item_name))
			item_big.global_position = targetPosition
			var sprite_tape = Sprite2D.new()
			sprite_tape.scale = Vector2(0.5, 0.5)
			sprite_tape.rotation_degrees = randi_range(70, 110)
			sprite_tape.texture = load("res://images/items/big/short_tape.png")
			item_big.add_child(sprite_tape)
			if targetPosition == Hand.global_position:
				sprite_tape.position = targetPosition
			targetPosition = item_big.get_node("end").global_position
			lastPosition = item_big.get_node("start").global_position
			current_length += 2

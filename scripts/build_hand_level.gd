extends Node2D

@onready var item_length_1: PackedScene = preload("res://scenes/item_length_1.tscn")
@onready var item_length_2: PackedScene = preload("res://scenes/item_length_2.tscn")
@onready var item_slot: PackedScene = preload("res://scenes/item_slot.tscn")
@onready var label: Label = $TapeCounter/Label
@onready var length_label: Label = $Length/LengthLabel
@onready var durability_label: Label = $Durability/DurabilityLabel
@onready var length_bar: TextureProgressBar = $Length/LengthBar/TextureProgressBar
@onready var durability_bar: TextureProgressBar = $Durability/DurabilityBar/TextureProgressBar
@onready var hand: Node2D = $Hand
@onready var items: Node = $Items

@onready var lastPosition = $Hand.global_position
@onready var targetPosition = $Hand.global_position

var needed_length = 10
var needed_durability = 5

var durability = 0
var length = 0

var not_empty_slots = 0
func _ready():
	for item in Equipment.current_items:
		var i = 0
		var new_item = item_slot.instantiate()
		new_item.set_item(item)
		new_item.position = Vector2(randi_range(100, 1820), randi_range(540, 800))
		items.add_child(new_item)
		new_item.item_slot_pressed.connect(_on_item_slot_pressed)


func _physics_process(delta: float) -> void:
	pass

func _on_item_slot_pressed(item_name):
	if(Equipment._return_length(item_name) == 1 && length < needed_length):
		var item_big = item_length_1.instantiate()
		hand.add_child(item_big)
		item_big.get_node("Sprite2D").texture = load(Equipment._return_texture_big_name(item_name))
		item_big.position = targetPosition
		var sprite_tape = Sprite2D.new()
		sprite_tape.scale = Vector2(0.5, 0.5)
		sprite_tape.rotation_degrees = randi_range(70, 110)
		sprite_tape.texture = load("res://images/items/big/short_tape.png")
		item_big.add_child(sprite_tape)
		if targetPosition == $Hand.global_position:
			sprite_tape.position = targetPosition
		targetPosition = item_big.get_node("end").global_position
		lastPosition = item_big.get_node("start").global_position
		length += 1
	else:
		var item_big = item_length_2.instantiate()
		hand.add_child(item_big)
		item_big.get_node("Sprite2D").texture = load(Equipment._return_texture_big_name(item_name))
		item_big.global_position = targetPosition
		var sprite_tape = Sprite2D.new()
		sprite_tape.scale = Vector2(0.5, 0.5)
		sprite_tape.rotation_degrees = randi_range(70, 110)
		sprite_tape.texture = load("res://images/items/big/short_tape.png")
		item_big.add_child(sprite_tape)
		if targetPosition == $Hand.global_position:
			sprite_tape.position = targetPosition
		targetPosition = item_big.get_node("end").global_position
		lastPosition = item_big.get_node("start").global_position
		length += 2
	
	
	
func _input(event):
	if event.is_action_pressed("quit"):
		get_tree().quit()  
		

	

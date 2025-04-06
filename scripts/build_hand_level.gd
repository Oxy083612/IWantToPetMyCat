extends Node2D

@onready var item_length_1: PackedScene = preload("res://scenes/item_length_1.tscn")
@onready var item_length_2: PackedScene = preload("res://scenes/item_length_2.tscn")
@onready var item_slot: PackedScene = preload("res://scenes/item_slot.tscn")
@onready var label: Label = $TapeCounter/Label
@onready var length_label: Label = $Length/LengthLabel
@onready var durability_label: Label = $Durability/DurabilityLabel
@onready var length_bar: TextureProgressBar = $Length/LengthBar/TextureProgressBar
@onready var durability_bar: TextureProgressBar = $Durability/DurabilityBar/TextureProgressBar
@onready var items: Node = $Items

@onready var lastPosition = Hand.global_position
@onready var targetPosition = Hand.global_position


var not_empty_slots = 0
func _ready():
	for item in Equipment.current_items:
		var i = 0
		var new_item = item_slot.instantiate()
		new_item.set_item(item)
		new_item.position = Vector2(randi_range(200, 1720), randi_range(600, 800))
		items.add_child(new_item)
		new_item.item_slot_pressed.connect(_on_item_slot_pressed)


func _physics_process(delta: float) -> void:
	pass

func _on_item_slot_pressed(item_name):
	if(Equipment.tapes <= 0):
		return
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
		Hand.current_items.append(item_name)
		Hand.length += 1
		Hand.durability += Equipment._return_durability(item_name)

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
		Hand.current_items.append(item_name)
		Hand.length += 2
		Hand.durability += Equipment._return_durability(item_name)
	Equipment.tapes -= 1
	Hand.real_durability = Hand.durability / len(Hand.current_items)
	length_label.text = "Length\n" + str(Hand.length) + "/" + str(GameLoop.min_length)
	durability_label.text = "Durability\n" + str(Hand.real_durability) + "/" + str(GameLoop.min_durability)
	length_bar.value = min(Hand.length, GameLoop.min_length) * 100 / GameLoop.min_length
	durability_bar.value = min(Hand.real_durability, GameLoop.min_durability) * 100 / GameLoop.min_durability
	
	
	
func _input(event):
	if event.is_action_pressed("quit"):
		get_tree().quit()  
		


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/pat_pat_scene.tscn")	

extends Node2D

@onready var item_length_1: PackedScene = preload("res://scenes/hand_building/item_length_1.tscn")
@onready var item_length_2: PackedScene = preload("res://scenes/hand_building/item_length_2.tscn")
@onready var item_slot: PackedScene = preload("res://scenes/hand_building/buildable_item.tscn")
@onready var label: Label = $TapeCounter/Label
@onready var length_label: Label = $Length/LengthLabel
@onready var durability_label: Label = $Durability/DurabilityLabel
@onready var length_bar: TextureProgressBar = $Length/LengthBar/TextureProgressBar
@onready var durability_bar: TextureProgressBar = $Durability/DurabilityBar/TextureProgressBar
@onready var items: Node = $Items
@onready var undo_button: TextureButton = $Undo


@onready var item_level = 0
@onready var last_item = null
@onready var MAX_ITEM_LEVEL = 2
@onready var MAX_LENGTH = Hand.MAX_LENGTH
@onready var lastPosition = Hand.global_position
@onready var targetPosition = Hand.global_position


var not_empty_slots = 0
func _ready():
	var i = 0
	for item in Equipment.current_items:
		var new_item = item_slot.instantiate()
		new_item.set_item(item, i)
		new_item.global_position = Vector2(randi_range(200, 1720), randi_range(799, 800))
		print(new_item.global_position)
		items.add_child(new_item)
		new_item.item_slot_pressed.connect(_on_item_slot_pressed)
		i += 1


func _physics_process(delta: float) -> void:
	pass

func _on_item_slot_pressed(item_name, item_ID):
	if Equipment.tapes <= 0:
		return
	var item_big
	var sprite_tape = Sprite2D.new()
	if Hand.get_child_count() == 0 or Equipment._return_type(Hand.get_child(Hand.get_child_count() - 1)._name) != 2:
		if Hand.get_child_count() > 0:
			var last_item_node = Hand.get_child(Hand.get_child_count() - 1)
			lastPosition = last_item_node.get_node("left").global_position
		else:
			lastPosition = Hand.global_position
			
		if Equipment._return_length(item_name) == 1:
			item_big = item_length_1.instantiate()
		else:
			item_big = item_length_2.instantiate()
		item_big.ID = item_ID
		item_big._name = item_name
		if Hand.length != 0:
			sprite_tape.scale = Vector2(0.75, 0.75)
			sprite_tape.rotation_degrees = randi_range(70, 110)
			sprite_tape.texture = load("res://images/items/big/short_tape.png")
			sprite_tape.z_index = 10
			item_big.add_child(sprite_tape)
		Hand.length += Equipment._return_length(item_name)
		Hand.add_child(item_big)
		item_big.get_node("Sprite2D").texture = load(Equipment._return_texture_big_name(item_name))
		item_big.get_node("Sprite2D").z_index = 5
		item_big.global_position = targetPosition
		var direction = 0
		if item_level == 2:
			direction = -1
		elif item_level == -2:
			direction = 1
		else:
			direction = randi_range(0, 1) * 2 - 1
		item_level += direction
		if direction == -1:
			targetPosition = item_big.get_node("left").global_position
		else:
			targetPosition = item_big.get_node("right").global_position
		var start = lastPosition
		var end = item_big.global_position
		sprite_tape.global_position = (start + end) / 2.0
		last_item = item_ID
		Equipment.tapes -= 1
		Hand.current_items.append(item_name)
		Hand.durability += Equipment._return_durability(item_name)
		Hand.real_durability = Hand.durability / len(Hand.current_items)
		length_label.text = "Length\n" + str(Hand.length) + "/" + str(GameLoop.min_length)
		durability_label.text = "Durability\n" + str(Hand.real_durability) + "/" + str(GameLoop.min_durability)
		length_bar.value = min(Hand.length, GameLoop.min_length) * 100 / GameLoop.min_length
		durability_bar.value = min(Hand.real_durability, GameLoop.min_durability) * 100 / GameLoop.min_durability
	elif Equipment._return_type(item_name) == 1 and Hand.length + Equipment._return_length(item_name) <= MAX_LENGTH:
		if Hand.get_child_count() > 0:
			var last_item_node = Hand.get_child(Hand.get_child_count() - 1)
			lastPosition = last_item_node.get_node("right").global_position
		else:
			lastPosition = Hand.global_position

		if Equipment._return_length(item_name) == 1:
			item_big = item_length_1.instantiate()
		else:
			item_big = item_length_2.instantiate()
		item_big.ID = item_ID
		
		if Hand.length != 0:
			sprite_tape.scale = Vector2(0.75, 0.75)
			sprite_tape.rotation_degrees = randi_range(70, 110)
			sprite_tape.texture = load("res://images/items/big/short_tape.png")
			sprite_tape.z_index = 10
			item_big.add_child(sprite_tape)
			
		Hand.length += Equipment._return_length(item_name)
		Hand.add_child(item_big)
		item_big.get_node("Sprite2D").texture = load(Equipment._return_texture_big_name(item_name))
		item_big.get_node("Sprite2D").z_index = 5
		item_big.global_position = lastPosition

		targetPosition = item_big.get_node("right").global_position
		
		var start = lastPosition
		var end = item_big.global_position
		sprite_tape.global_position = (start + end) / 2.0
		
		last_item = item_ID
		Equipment.tapes -= 1
		Hand.current_items.append(item_name)
		Hand.durability += Equipment._return_durability(item_name)
		Hand.real_durability = Hand.durability / len(Hand.current_items)
		length_label.text = "Length\n" + str(Hand.length) + "/" + str(GameLoop.min_length)
		durability_label.text = "Durability\n" + str(Hand.real_durability) + "/" + str(GameLoop.min_durability)
		length_bar.value = min(Hand.length, GameLoop.min_length) * 100 / GameLoop.min_length
		durability_bar.value = min(Hand.real_durability, GameLoop.min_durability) * 100 / GameLoop.min_durability
		
		
func _input(event):
	if event.is_action_pressed("quit"):
		get_tree().quit()  
		


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/pat_pat/pat_pat_scene.tscn")	


func _on_undo_button_down() -> void:
	if Hand.get_child_count() == 0:
		return
	var x = Hand.get_child(Hand.get_child_count() - 1)
	var next_last_node: Node = null
	if Hand.get_child_count() > 1:
		next_last_node = Hand.get_child(Hand.get_child_count() - 2)
	for y in items.get_children():
		if x.ID == y.item_number:
			x.queue_free()
			y.is_used = false
			y.set_modulate(Color(1, 1, 1))
			Hand.current_items.pop_back()
			if Hand.current_items == []:
				Hand.length = 0
				Hand.durability = 0
				Hand.real_durability = 0
				lastPosition = Hand.position
				targetPosition = Hand.position
			else:
				Hand.length -= Equipment._return_length(y.item_name)
				Hand.durability -= Equipment._return_durability(y.item_name)
				Hand.real_durability = Hand.durability / len(Hand.current_items)
			length_label.text = "Length\n" + str(Hand.length) + "/" + str(GameLoop.min_length)
			durability_label.text = "Durability\n" + str(Hand.real_durability) + "/" + str(GameLoop.min_durability)
			length_bar.value = min(Hand.length, GameLoop.min_length) * 100 / GameLoop.min_length
			durability_bar.value = min(Hand.real_durability, GameLoop.min_durability) * 100 / GameLoop.min_durability
			var rng = randi_range(0, 1)
			if next_last_node != null:
				targetPosition = next_last_node.get_node("left").global_position
			else:
				targetPosition = Hand.global_position
			Equipment.tapes += 1
			if item_level > 0:
				item_level -= 1
			elif item_level < 0:
				item_level += 1
			return

	
	

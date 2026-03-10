extends Node2D

@onready var item_length_1: PackedScene = preload("res://scenes/hand_building/item_length_1.tscn")
@onready var item_length_2: PackedScene = preload("res://scenes/hand_building/item_length_2.tscn")
@onready var item_slot: PackedScene = preload("res://scenes/hand_building/buildable_item.tscn")
@onready var label: Label = $TapeCounter/Label
@onready var length_label: Label = $Length/LengthLabel
@onready var durability_label: Label = $Durability/DurabilityLabel
@onready var quality_label: Label = $Quality/QualityLabel
@onready var items: Node = $Items
@onready var undo_button: TextureButton = $Undo


@onready var item_level = 0
@onready var last_item = null
@onready var MAX_ITEM_LEVEL = 2
@onready var MAX_LENGTH = Hand.MAX_LENGTH


var not_empty_slots = 0
func _ready():
	var i = 0
	for item in Equipment.current_items:
		var new_item = item_slot.instantiate()
		new_item.set_item(item, i)
		new_item.global_position = Vector2(randi_range(200, 1720), randi_range(799, 800))
		items.add_child(new_item)
		new_item.item_slot_pressed.connect(_on_item_slot_pressed)
		i += 1


func _physics_process(delta: float) -> void:
	pass


func add_tape(sprite_tape, item_big):
	sprite_tape.scale = Vector2(0.75, 0.75)
	sprite_tape.rotation_degrees = randi_range(70, 110)
	sprite_tape.texture = load("res://images/items/big/short_tape.png")
	sprite_tape.z_index = 10
	item_big.add_child(sprite_tape)
	Equipment.tapes -= 1


func show_hand_stats():
	length_label.text = "Length: " + str(Hand.length)
	durability_label.text = "Durability: " + str(Hand.durability)
	quality_label.text = "Quality: " + str(Hand.quality)


func add_item_to_hand(item_name, item_big):
	Hand.current_items.append(item_name)
	Hand.length += Equipment._return_length(item_name)
	Hand.add_child(item_big)
	item_big.get_node("Sprite2D").texture = load(Equipment._return_texture_big_name(item_name))
	item_big.get_node("Sprite2D").z_index = 5
	Hand.durability += Equipment._return_durability(item_name)
	Hand.quality += Equipment._return_quality(item_name)
	show_hand_stats()


func connect_item_using_tape(item_big, sprite_tape, item_ID, item_name):
	add_item_to_hand(item_name, item_big)
	item_big.global_position = Hand.targetPosition
	var direction = 0
	if item_level == 2:
		direction = -1
	elif item_level == -2:
		direction = 1
	else:
		direction = randi_range(0, 1) * 2 - 1
	item_level += direction
	if direction == -1:
		Hand.targetPosition = item_big.get_node("left").global_position
	else:
		Hand.targetPosition = item_big.get_node("right").global_position
	var start = Hand.lastPosition
	var end = item_big.global_position
	sprite_tape.global_position = (start + end) / 2.0
	last_item = item_ID


func connect_end_using_tape(item_big, sprite_tape, item_ID, item_name):
	add_item_to_hand(item_name, item_big)
	item_big.global_position = Hand.lastPosition
	Hand.targetPosition = item_big.get_node("right").global_position
	var start = Hand.lastPosition
	var end = item_big.global_position
	sprite_tape.global_position = (start + end) / 2.0
	last_item = item_ID
	

func create_item(item_name, item_ID, is_end):
	var item_big
	if Equipment._return_length(item_name) == 1:
		item_big = item_length_1.instantiate()
	else:
		item_big = item_length_2.instantiate()
	item_big.ID = item_ID
	if not is_end:
		item_big._name = item_name
	return item_big
	

func _on_item_slot_pressed(item_name, item_ID):
	if Equipment.tapes <= 0 and Hand.length > 0:
		return
	var item_big
	var sprite_tape = Sprite2D.new()
	if Hand.get_child_count() == 0 or Equipment._return_type(Hand.get_child(Hand.get_child_count() - 1)._name) != 2:
		if Hand.get_child_count() > 0:
			var last_item_node = Hand.get_child(Hand.get_child_count() - 1)
			Hand.lastPosition = last_item_node.get_node("left").global_position
		else:
			Hand.lastPosition = Hand.global_position
		item_big = create_item(item_name, item_ID, false)
		if Hand.length != 0:
			add_tape(sprite_tape, item_big)
		connect_item_using_tape(item_big, sprite_tape, item_ID, item_name)
	elif Equipment._return_type(item_name) == 1 and Hand.length + Equipment._return_length(item_name) <= MAX_LENGTH:
		if Hand.get_child_count() > 0:
			var last_item_node = Hand.get_child(Hand.get_child_count() - 1)
			Hand.lastPosition = last_item_node.get_node("right").global_position
		else:
			Hand.lastPosition = Hand.global_position
		item_big = create_item(item_name, item_ID, true)
		if Hand.length != 0:
			add_tape(sprite_tape, item_big)
		connect_end_using_tape(item_big, sprite_tape, item_ID, item_name)
		
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
				Hand.quality = 0
				Hand.lastPosition = Hand.position
				Hand.targetPosition = Hand.position
			else:
				Hand.length -= Equipment._return_length(y.item_name)
				Hand.durability -= Equipment._return_durability(y.item_name)
				Hand.quality -= Equipment._return_quality(y.item_name)
			show_hand_stats()
			var rng = randi_range(0, 1)
			if next_last_node != null:
				Hand.targetPosition = next_last_node.get_node("left").global_position
			else:
				Hand.targetPosition = Hand.global_position
			Equipment.tapes += 1
			if item_level > 0:
				item_level -= 1
			elif item_level < 0:
				item_level += 1
			return

extends Node2D

@onready var item_length_1: PackedScene = preload("res://scenes/item_length_2.tscn")
@onready var item_length_2: PackedScene = preload("res://scenes/item_length_1.tscn")
@onready var item_slot: PackedScene = preload("res://scenes/item_slot.tscn")
@onready var label: Label = $TapeCounter/Label
@onready var length_label: Label = $Length/LengthLabel
@onready var durability_label: Label = $Durability/DurabilityLabel
@onready var length_bar: TextureProgressBar = $Length/LengthBar/TextureProgressBar
@onready var durability_bar: TextureProgressBar = $Durability/DurabilityBar/TextureProgressBar
@onready var hand: Node2D = $Hand
@onready var items: Node = $Items

var needed_length = 10
var needed_durability = 5

var not_empty_slots = 0
func _ready():
	for item in Equipment.current_items:
		var i = 0
		var new_item = item_slot.instantiate()
		items.add_child(new_item)
		new_item.item_slot_pressed.connect(_on_item_slot_add)
		if item.length == 1:
			items.get_child(i).add_child(item_length_1.instantiate())
			new_item.get_child(0).get_node("Sprite2D").texture = item["texture"]
			i+=1
		else:
			items.get_child(i).add_child(item_length_1.instantiate())
			new_item.get_child(0).get_node("Sprite2D").texture = item["texture"]
			i+=1
		
func _on_item_slot_add():
	
	pass
	
	
func _input(event):
	if event.is_action_pressed("quit"):
		get_tree().quit()	



func _physics_process(delta: float) -> void:
	var length = 0.0
	var durability = 0.0
	var used_items = 0
	var hand_skeleton = []
	var hand_end
	for x in items.get_children():
		var y = x.get_child(0)
		if x != null and y != null:
			length += slot.item["length"]
			durability += slot.item["durability"]
			used_items += 1
	hand.set_parts(hand_skeleton, hand_end)
	durability /= used_items
	length_label.text = "Length\n" + str(length) + "/" + str(needed_length)
	length_bar.set_value((min(length, needed_length) * 100) / needed_length)
	if used_items > 0:
		durability_label.text = "Durability\n" + str(durability) + "/" + str(needed_durability)
		durability_bar.set_value(min(durability, needed_durability) / needed_durability * 100)
	else:
		durability_label.text = "Durability\n" + "0/" + str(needed_durability)
		durability_bar.set_value(0)
		

	

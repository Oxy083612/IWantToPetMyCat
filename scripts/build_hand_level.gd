extends Node2D

@onready var item_slot: TextureButton = $ItemSlot
@onready var item_slot_3: TextureButton = $ItemSlot3
@onready var item_slot_4: TextureButton = $ItemSlot4
@onready var item_slot_2: TextureButton = $ItemSlot2
@onready var item_slot_5: TextureButton = $ItemSlot5
@onready var item_slot_6: TextureButton = $ItemSlot6

@onready var item_slots = [item_slot, item_slot_3, item_slot_4, item_slot_2, item_slot_5, item_slot_6]

@onready var label: Label = $TapeCounter/Label
@onready var length_label: Label = $Length/LengthLabel
@onready var durability_label: Label = $Durability/DurabilityLabel
@onready var length_bar: TextureProgressBar = $Length/LengthBar/TextureProgressBar
@onready var durability_bar: TextureProgressBar = $Durability/DurabilityBar/TextureProgressBar
@onready var hand: Node2D = $Hand

var needed_length = 10
var needed_durability = 5

var not_empty_slots = 0
func _ready():
	for item in Equipment.current_items:
		item_slots[not_empty_slots].set_item(item)
		print(item)
		not_empty_slots += 1

func _input(event):
	if event.is_action_pressed("quit"):
		get_tree().quit()	

func _physics_process(delta: float) -> void:
	var length = 0.0
	var durability = 0.0
	var used_items = 0
	var hand_skeleton = []
	var hand_end
	for i in range(not_empty_slots):
		var slot = item_slots[i]
		if slot.is_used:
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
		
	
	

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
		new_item.item_slot_pressed.connect(_on_item_slot_add)
		
		if Equipment._return_length(item) == 1:
			items.get_child(i).add_child(item_length_1.instantiate())
			i+=1
		else:
			items.get_child(i).add_child(item_length_1.instantiate())
			i+=1

func _physics_process(delta: float) -> void:
	pass

func _on_item_slot_add(item_name):
	print("bu")
	length += Equipment._return_length(item_name)
	durability += Equipment._return_durability(item_name)
	pass
	
	
func _input(event):
	if event.is_action_pressed("quit"):
		get_tree().quit()	


		

	

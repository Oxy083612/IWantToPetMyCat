extends Node

signal change_item(item)
#{"name": "Twig", "texture": "res://images/items/Twig.png", "type": item_types.stick, "length": 1},
	#{"name": "Pen", "texture": "res://images/items/stick.png", "type": item_types.stick, "length": 3},
	#{"name": "SuperGlue", "texture": "res://images/items/SuperGlue.png", "type": item_types.tape, "durability": 1},
	#{"name": "InsulatingTape", "texture": "res://images/items/InsulatingTape.png", "type": item_types.tape, "durability": 2},

	
@onready var item: PackedScene = preload("res://scenes/item.tscn")
@onready var item_list = []
@onready var item_space_list = get_children()
@onready var item_space_list_tmp
var number_of_items

#linijka, długopis, łapka na muchy, patyk, kij, taśma, duct tape, pilot do telewizora, szczotka do kibla, 


func _ready():		
	var number_of_items = (int) ((item_space_list.size() * 3) / 4)
	item_space_list_tmp = item_space_list.duplicate(true)
	for x in range(number_of_items):
		var tmp = item_space_list_tmp.pick_random()
		item_space_list_tmp.erase(tmp)
		tmp.add_child(item.instantiate())
		item_list.append(tmp.get_node("Item"))
		var item_tmp = tmp.get_node("Item")
		var picked_item = _pick_item_from_list()
		item_space_list[x].item = picked_item
		emit_signal("change_item", picked_item)
		
func _pick_item_from_list():
	match randi_range(0, 1):
		0:
			return ItemsPool.items["stick"]
		1:
			return ItemsPool.items["ductTape"]

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
var min_tapes = 2
var tapes = ["glue", "ductTape", "isolationTape"]

func _ready():		
	var number_of_items = (int) ((item_space_list.size() * 3) / 4)
	item_space_list_tmp = item_space_list.duplicate(true)
	
	var chosen_tapes = 0
	while chosen_tapes < min_tapes:
		var choice = randi() % item_space_list_tmp.size()
		var tmp = item_space_list_tmp.pick_random()
		item_space_list_tmp.erase(tmp)
		tmp.add_child(item.instantiate())
		item_list.append(tmp.get_node("Item"))
		var item_tmp = tmp.get_node("Item")
		var picked_item = _pick_tape()
		item_space_list[choice].item = picked_item
		emit_signal("change_item", picked_item)
		chosen_tapes += 1
	
	for x in range(number_of_items - min_tapes):
		var tmp = item_space_list_tmp.pick_random()
		item_space_list_tmp.erase(tmp)
		tmp.add_child(item.instantiate())
		item_list.append(tmp.get_node("Item"))
		var item_tmp = tmp.get_node("Item")
		var picked_item = _pick_item_from_list()
		item_space_list[x].item = picked_item
		emit_signal("change_item", picked_item)

func _pick_tape():
	var choice = tapes[randi() % tapes.size()]
	return ItemsPool.items[choice]

func _pick_item_from_list():
	var keys = []
	for key in ItemsPool.items.keys():
		keys.append(key)
	var choice = keys[randi() % keys.size()]
	return ItemsPool.items[choice]

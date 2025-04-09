extends Node

signal change_item(item_name)

@onready var item: PackedScene = preload("res://scenes/item_gathering/pickup_item.tscn")
@onready var item_list = []
@onready var item_space_list = get_children()
@onready var item_space_list_tmp
var number_of_items

var min_tapes = 2
var tapes = ItemsPool.get_tapes()

func _ready():		
	number_of_items = (int) ((item_space_list.size() * 3) / 4)
	item_space_list_tmp = item_space_list.duplicate(true)

	var added_tapes = 0
	var added_items = 0
	while added_items < number_of_items or added_tapes < min_tapes:
		var tmp = item_space_list_tmp.pick_random()
		item_space_list_tmp.erase(tmp)
		tmp.add_child(item.instantiate())
		item_list.append(tmp.get_node("Item"))
		var picked_item
		if added_items < number_of_items:
			picked_item = _pick_item_from_list()
		else:
			picked_item = _pick_tape_from_list()
		var item_name = picked_item["name"]
		tmp.item_name = item_name
		emit_signal("change_item", item_name)
		added_items += 1
		if picked_item["type"] == ItemsPool.item_types.tape:
			added_tapes += 1
		
		
func _pick_tape_from_list():
	var choice = tapes[randi() % tapes.size()]
	return ItemsPool.items[choice]

func _pick_item_from_list():
	var keys = []
	for key in ItemsPool.items.keys():
		keys.append(key)
	var choice = keys[randi() % keys.size()]
	return ItemsPool.items[choice]

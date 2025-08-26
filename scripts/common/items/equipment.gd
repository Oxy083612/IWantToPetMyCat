extends Node

enum item_types{
	stick, tape, end	
}

var current_items = ["baguette","baguette","baguette", "slipper"]

func _return_texture_big_name(item: String):
	return ItemsPool.items[item].get("texture_big")
	
func _return_texture_name(item: String):
	return ItemsPool.items[item].get("texture")
	
func _return_name(item: String):
	return ItemsPool.items[item].get("name")

func _return_durability(item: String):
	return ItemsPool.items[item].get("durability")

func _return_length(item: String):
	return ItemsPool.items[item].get("length")

func _return_type(item: String):
	return ItemsPool.items[item].get("type")
	

@export var tapes = 10

func add_item(item):
	if(ItemsPool.items[item]["type"] == ItemsPool.item_types.tape):
		tapes += 1
	else:
		current_items.append(item)
		return true
	return false 

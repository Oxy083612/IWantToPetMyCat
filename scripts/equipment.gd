extends Node

enum item_types{
	stick, tape, end	
}

var current_items = [
]

func _return_texture_big_name(item: String):
	return ItemsPool.items[item].get("texture_big")
	
	
func _return_texture_name(item: String):
	return ItemsPool.items[item].get("texture")
	
func _return_name(item: String):
	return ItemsPool.items[item].get("name")
	

var tapes = 0

func add_item(item):
	if item == "ductTape":
		tapes+=1
		return true
	if(len(current_items) < 6):
		current_items.append(item)	
		return true
	return false 

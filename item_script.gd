extends Node2D

var _item

@onready var sprite = $Sprite2D
@onready var item_generation = get_parent().get_parent()


func _ready():
	item_generation.change_item.connect(_on_item_generation_change_item)
	pass
	
func _on_item_generation_change_item(item: Variant) -> void:
	print(item)
	_change_parameters(item)
	item_generation.change_item.disconnect(_on_item_generation_change_item)
	pass

func _change_parameters(item):
	print(item)
	_item = item
	sprite.texture = load(_item["texture"])
	pass

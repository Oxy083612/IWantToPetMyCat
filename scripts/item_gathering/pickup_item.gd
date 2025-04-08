extends Node2D

@onready var sprite = $Sprite2D
@onready var item_generation = get_parent().get_parent()
@onready var parent = get_parent()


func _ready():
	item_generation.change_item.connect(_on_item_generation_change_item)
	
func _on_item_generation_change_item(item_name) -> void:
	var item = ItemsPool.items[item_name]
	print(item_name, " ", item["texture"])
	sprite.texture = load(item["texture"])
	parent.item_name = item_name
	item_generation.change_item.disconnect(_on_item_generation_change_item)

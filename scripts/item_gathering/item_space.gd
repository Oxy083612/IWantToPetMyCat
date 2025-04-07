extends Node

@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D
@onready var item_name = null
@onready var label_desc: Label = $"../../HUDSearchItems/Label"

@onready var player = get_parent().get_parent().get_node("Player")

func _ready():
	player.destroy_item.connect(_on_item_destroy)
	player.show_item.connect(_on_item_show)
	player.hide_item.connect(_on_item_hide)

func _on_item_destroy(id):
	if item_name == null:
		return
	if(player.item_held == null):
		return
	if(self.get_instance_id() != id ):
		return
	queue_free()
	
func _on_item_show(id):
	if item_name == null:
		return
	if(self.get_instance_id() != id):
		return
	label_desc.text = item_name

func _on_item_hide(id):
	if item_name == null:
		return
	if(self.get_instance_id() != id):
		return
	label_desc.text = ""

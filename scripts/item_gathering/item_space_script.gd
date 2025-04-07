extends Node

@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D
@onready var item = null
@export var item_name = null

@onready var player = get_parent().get_parent().get_node("Player")

func _ready():
	player.destroy_item.connect(_on_item_destroy)

func _on_item_destroy(id):
	if(player.item_held == null):
		return
	if(self.get_instance_id() != id ):
		return
	queue_free()

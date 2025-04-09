extends StaticBody2D
@onready var player = get_parent().get_node("Player")

func _ready():
	player.destroy_item.connect(_on_get_item)

func _on_get_item(id):
	if(self.get_instance_id() != id ):
		return
	var item = player.item_held
	if(item != null):
		if(item.type == Equipment.item_types.tape):
			Equipment.tapes += 1
			player.item_held = null	
		elif(Equipment.add_item(item)):
			player.item_held = null

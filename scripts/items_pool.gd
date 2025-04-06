extends Node

enum item_types { stick, tape, end }

@onready var items = {
	"stick": {"name": "stick", "texture": "res://images/Item-11.png", "texture_big": "res://images/Item-11.png", "texture_build": "res://images", "type": item_types.stick, "length": 2, "durability": 3},
	"baguette": {"name": "baguette", "texture": "res://images/Item-1.png", "texture_big": "res://images/Item-1.png", "texture_build": "res://images", "type": item_types.stick, "length": 2, "durability": 1},
	"glue": {"name": "glue", "texture": "res://images/Item-5.png", "type": item_types.tape,},
	"ductTape" : {"name": "ductTape", "texture": "res://images/Item-2.png", "type": item_types.tape},
	"isolationTape": {"name": "isolationTape", "texture": "res://images/Item-6.png", "type": item_types.tape},
	"remote": {"name": "remote", "texture": "res://images/Item-7.png", "texture_big": "res://images/Item-7.png", "texture_build": "res://images", "type": item_types.stick, "length": 1, "durability": 3},
	"ball": {"name": "ball", "texture": "res://images/Item-8.png", "texture_big": "res://images/Item-8.png", "texture_build": "res://images", "type": item_types.stick, "length": 2, "durability": 3},
}

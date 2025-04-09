extends Node

enum item_types { stick, tape, end }

@onready var items = {
	"stick": {
		"name": "stick",
		"texture": "res://images/items/small/Item-11.png",
		"texture_big": "res://images/items/big/Stick.png",
		"texture_build": "res://images",
		"type": item_types.stick,
		"length": 2,
		"durability": 3
		},
	"baguette": {
		"name": "baguette",
		 "texture": "res://images/items/small/Item-1.png",
		 "texture_big": "res://images/items/big/Biegietka.png",
		 "texture_build": "res://images",
		 "type": item_types.stick,
		 "length": 2,
		 "durability": 2
		},
	"glue": {
		"name": "glue",
		 "texture": "res://images/items/small/Item-5.png",
		 "type": item_types.tape,
		},
	"duct tape" : {
		"name": "duct tape", "texture": "res://images/items/small/Item-2.png",
		 "type": item_types.tape
		},
	"isolation tape": {
		"name": "isolation tape",
		 "texture": "res://images/items/small/Item-6.png",
		 "type": item_types.tape
		},
	"remote": {
		"name": "remote",
		 "texture": "res://images/items/small/Item-7.png",
		 "texture_big": "res://images/items/big/Pilot.png",
		 "texture_build": "res://images",
		 "type": item_types.stick,
		 "length": 1,
		 "durability": 4
	},
	"slipper": {
		"name": "slipper",
		 "texture": "res://images/items/small/Item-13.png",
		 "texture_big": "res://images/items/big/Klapek.png",
		 "texture_build": "res://images",
		 "type": item_types.end,
		 "length": 1,
		 "durability": 4
	},
	"ruler": {
		"name": "ruler",
		 "texture": "res://images/items/small/Item-16.png",
		 "texture_big": "res://images/items/big/Linijka.png",
		 "texture_build": "res://images",
		 "type": item_types.stick,
		 "length": 1,
		 "durability": 1
	},
	"whisk": {
		"name": "whisk",
		 "texture": "res://images/items/small/Item-4.png",
		 "texture_big": "res://images/items/big/Packa.png",
		 "texture_build": "res://images",
		 "type": item_types.end,
		 "length": 2,
		 "durability": 2
	},
	"pillow": {
		"name": "pillow",
		 "texture": "res://images/items/small/Item-14.png",
		 "texture_big": "res://images/items/big/Poduszka.png",
		 "texture_build": "res://images",
		 "type": item_types.stick,
		 "length": 1,
		 "durability": 3
	},
	"newspaper": {
		"name": "newspaper",
		 "texture": "res://images/items/small/Item-15.png",
		 "texture_big": "res://images/items/big/Sto.png",
		 "texture_build": "res://images",
		 "type": item_types.stick,
		 "length": 2,
		 "durability": 1
	},
	"toilet brush": {
		"name": "toilet brush",
		 "texture": "res://images/items/small/Item-9.png",
		 "texture_big": "res://images/items/big/Szczotka.png",
		 "texture_build": "res://images",
		 "type": item_types.end,
		 "length": 2,
		 "durability": 2
	},
}

func get_tapes():
	return ["duct tape", "glue", "isolation tape"]

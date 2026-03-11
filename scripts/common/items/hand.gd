extends Node2D

@onready var length = 0
@onready var durability = 0
@onready var quality = 0
@onready var current_length = 0
@onready var current_items = []
@onready var MAX_LENGTH = 12

@onready var item_length_1: PackedScene = preload("res://scenes/hand_building/item_length_1.tscn")
@onready var item_length_2: PackedScene = preload("res://scenes/hand_building/item_length_2.tscn")
@onready var item_slot: PackedScene = preload("res://scenes/hand_building/buildable_item.tscn")

@onready var lastPosition
@onready var targetPosition

func reset():
	Hand.rotation = 0
	Hand.global_position = Vector2(250, 400)
	lastPosition = global_position
	targetPosition = global_position
	length = 0
	durability = 0
	quality = 0
	current_length = 0
	current_items = []
	for n in Hand.get_children():
		Hand.remove_child(n)
		n.queue_free() 

func _ready():
	Hand.global_position = Vector2(250, 400)
	z_index = 100
	lastPosition = global_position
	targetPosition = global_position

extends Node2D

var length = 0
var durability = 0
var real_durability = 0
var current_length = 0
var current_items = []
@onready var MAX_LENGTH = 12

@onready var item_length_1: PackedScene = preload("res://scenes/hand_building/item_length_1.tscn")
@onready var item_length_2: PackedScene = preload("res://scenes/hand_building/item_length_2.tscn")
@onready var item_slot: PackedScene = preload("res://scenes/hand_building/buildable_item.tscn")

var lastPosition
var targetPosition

func _ready():
	Hand.global_position = Vector2(250, 400)
	z_index = 100
	lastPosition = global_position
	targetPosition = global_position

extends Node2D

@onready var skeleton_part: PackedScene = preload("res://scenes/skeleton_part.tscn")


func set_parts(hand_skeleton, hand_end):
	for n in get_children():
		remove_child(n)	
	for bone in hand_skeleton:
		var part = skeleton_part.instantiate()
		part.get_node("Sprite").texture = load(bone["texture_big"])
		print(part.get_node("Sprite").texture)
		part.position.x = position.x
		part.position.y = position.y
		print(part.position)
		#part.rotation = deg_to_rad(270)
		print(part)

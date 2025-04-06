extends Node2D

var rng = RandomNumberGenerator.new()


func _input(event):
	if event.is_action_pressed("quit"):
		get_tree().quit()

func _ready():
	if Hand.length < GameLoop.min_length:
		print("Length too low")
	if Hand.durability < GameLoop.min_durability:
		var destroy_chance = int((GameLoop.min_durability - Hand.durability) * 100 / GameLoop.min_durability)

		var choice = rng.randi_range(0, 100)
		if choice < destroy_chance:
			print("Destroyed")
		else:
			print("Won")
	else:
		print("Won")
		
	
	

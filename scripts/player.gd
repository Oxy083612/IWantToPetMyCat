extends CharacterBody2D
signal destroy_item(id)
signal add_item(id)

const SPEED = 150.0
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var table: StaticBody2D = $"../Table"
@onready var area_2d: Area2D = $Area2D
@onready var label_desc: Label = $"../HUDSearchItems/Label"


enum DIRECTION {front, right, back, left}
var dir = DIRECTION.front
@export var item_held = null

func _physics_process(delta: float) -> void:	
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if(input_direction[0] > 0 and velocity != Vector2.ZERO):
		sprite.play("walk_right")
		dir = DIRECTION.right
	if(input_direction[0] < 0 and velocity != Vector2.ZERO):
		sprite.play("walk_left")
		dir = DIRECTION.left
	if(input_direction[1] > 0 and velocity != Vector2.ZERO):
		sprite.play("walk_front")
		dir = DIRECTION.front
	if(input_direction[1] < 0 and velocity != Vector2.ZERO):
		sprite.play("walk_back")
		dir = DIRECTION.back
	if velocity == Vector2.ZERO:
		match dir:
			DIRECTION.right:
				sprite.play("idle_right")
			DIRECTION.left:
				sprite.play("idle_left")
			DIRECTION.front:
				sprite.play("idle_front")
			DIRECTION.back:
				sprite.play("idle_back")
	velocity = input_direction * SPEED
	move_and_slide()


func _on_area_2d_body_entered(body) -> void:
	if item_held == null and body != table:
		item_held = body.item_name
		label_desc.text = "Return the item to the table"
		emit_signal("destroy_item", body.get_instance_id())
	elif item_held != null and body == table:
		Equipment.add_item(item_held)
		label_desc.text = ""
		item_held = null


func _on_area_2d_body_exited(body: Node2D) -> void:
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("pick_up"):
		area_2d.monitorable = true
	elif item_held != null:
		area_2d.monitorable = true
	else:
		area_2d.monitorable = false

extends AnimatedSprite2D
signal destroy_item(id)
signal show_item_name(id)
signal hide_item_name()

const SPEED = 150
@onready var table: StaticBody2D = $"../Table"
@onready var area_2d: Area2D = $Area2D
@onready var label_desc: Label = $"../HUDSearchItems/Label"
@onready var character_body_2d: CharacterBody2D = $CharacterBody2D


enum DIRECTION {front, right, back, left}
var dir = DIRECTION.front
@export var item_held = null
var pickable_bodies = []
var is_near_table = false

func _physics_process(_delta: float) -> void:
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if(input_direction[0] > 0 and character_body_2d.velocity != Vector2.ZERO):
		play("walk_right")
		dir = DIRECTION.right
	if(input_direction[0] < 0 and character_body_2d.velocity != Vector2.ZERO):
		play("walk_left")
		dir = DIRECTION.left
	if(input_direction[1] > 0 and character_body_2d.velocity != Vector2.ZERO):
		play("walk_front")
		dir = DIRECTION.front
	if(input_direction[1] < 0 and character_body_2d.velocity != Vector2.ZERO):
		play("walk_back")
		dir = DIRECTION.back
	if character_body_2d.velocity == Vector2.ZERO:
		match dir:
			DIRECTION.right:
				play("idle_right")
			DIRECTION.left:
				play("idle_left")
			DIRECTION.front:
				play("idle_front")
			DIRECTION.back:
				play("idle_back")
	character_body_2d.velocity = input_direction * SPEED
	character_body_2d.apply_floor_snap()
	character_body_2d.move_and_slide()
	global_position = character_body_2d.global_position
	character_body_2d.position = Vector2.ZERO

func _on_area_2d_body_entered(body) -> void:	
	if item_held == null:
		if body != table:
			emit_signal("show_item_name", body.get_instance_id())
			pickable_bodies.append(body)
		return
	if body == table:
		is_near_table = true
		label_desc.text = "put " + item_held + " on the table"
		
func _on_area_2d_body_exited(body) -> void:
	if body.get_instance_id() == table.get_instance_id():
		if item_held:
			label_desc.text = "take " + item_held + " to the table"
		is_near_table = false
	for pickable_body in pickable_bodies:
		if body.get_instance_id() == pickable_body.get_instance_id():
			pickable_bodies.erase(pickable_body)
	if len(pickable_bodies) > 0:
		emit_signal("show_item_name", pickable_bodies[-1].get_instance_id())
		return
	if not item_held:
		label_desc.text = ""

func _input(event):
	if not event.is_action_pressed("pick_up"):
		return
	if item_held == null and len(pickable_bodies) > 0:
		item_held = pickable_bodies[0].item_name
		label_desc.text = "take " + item_held + " to the table"
		emit_signal("destroy_item", pickable_bodies[-1].get_instance_id())
		pickable_bodies.erase(pickable_bodies[-1])
		return
	if item_held != null and is_near_table:
		Equipment.add_item(item_held)
		item_held = null
		label_desc.text = ""

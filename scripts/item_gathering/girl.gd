extends AnimatedSprite2D
signal destroy_item(id)
signal show_item_name(id)
signal hide_item_name()

const SPEED = 100
@onready var table: StaticBody2D = $"../Table"
@onready var area_2d: Area2D = $Area2D
@onready var label_desc: Label = $"../HUDSearchItems/Label"
@onready var character_body_2d: CharacterBody2D = $CharacterBody2D
@onready var walk_sound = $"../WalkSound"

@onready var level = get_parent()
@onready var top_left = Vector2(353, 283)
@onready var bottom_right = Vector2(386, 342)


enum DIRECTION {front, right, back, left}
var dir = DIRECTION.front
@export var item_held = null
var pickable_bodies = []
var is_near_table = false


func spawn_item(item):
	var sprite = Sprite2D.new()
	var item_texture = ItemsPool.items[item]["texture"]
	sprite.texture = load(item_texture)
	var x = randf_range(top_left.x, bottom_right.x)
	var y = randf_range(bottom_right.y, top_left.y)
	sprite.global_position = Vector2(x, y)
	sprite.z_index = 100
	level.add_child(sprite)


func _physics_process(_delta: float) -> void:
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if character_body_2d.velocity != Vector2.ZERO:
		if input_direction[1] > 0:
			play("walk_front")
			dir = DIRECTION.front
		elif input_direction[1] < 0:
			play("walk_back")
			dir = DIRECTION.back
		elif input_direction[0] > 0:
			play("walk_right")
			dir = DIRECTION.right
		elif input_direction[0] < 0:
			play("walk_left")
			dir = DIRECTION.left
		if not walk_sound.playing:
			walk_sound.play()
	else:
		match dir:
			DIRECTION.right:
				play("idle_right")
			DIRECTION.left:
				play("idle_left")
			DIRECTION.front:
				play("idle_front")
			DIRECTION.back:
				play("idle_back")
		if walk_sound.playing:
			walk_sound.stop()
	character_body_2d.velocity = input_direction * SPEED
	character_body_2d.apply_floor_snap()
	character_body_2d.move_and_slide()
	global_position = character_body_2d.global_position
	character_body_2d.position = Vector2.ZERO

func _on_area_2d_body_entered(body) -> void:
	if body != table and body.item_name != null:
		pickable_bodies.append(body)
		if not item_held:
			emit_signal("show_item_name", body.get_instance_id())
		return
	if body == table:
		is_near_table = true
		if item_held:
			label_desc.text = "press e to put " + item_held + " on the table"
		
func _on_area_2d_body_exited(body) -> void:
	if body.get_instance_id() == table.get_instance_id():
		if item_held:
			label_desc.text = "take " + item_held + " to the table"
		is_near_table = false
	for pickable_body in pickable_bodies:
		if body.get_instance_id() == pickable_body.get_instance_id():
			pickable_bodies.erase(pickable_body)
	if not item_held:
		if len(pickable_bodies) > 0:
			emit_signal("show_item_name", pickable_bodies[-1].get_instance_id())
			return
		label_desc.text = ""
		return
	label_desc.text = "take " + item_held + " to the table"

func _input(event):
	if not event.is_action_pressed("pick_up"):
		return
	if item_held == null and len(pickable_bodies) > 0:
		item_held = pickable_bodies[-1].item_name
		label_desc.text = "take " + item_held + " to the table"
		emit_signal("destroy_item", pickable_bodies[-1].get_instance_id())
		pickable_bodies.erase(pickable_bodies[-1])
		PickSound.play()
		return
	if item_held != null and is_near_table:
		Equipment.add_item(item_held)
		spawn_item(item_held)
		item_held = null
		if len(pickable_bodies) > 0:
			emit_signal("show_item_name", pickable_bodies[-1].get_instance_id())
		else:
			label_desc.text = ""
		PutSound.play()

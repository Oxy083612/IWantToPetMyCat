extends TextureButton
 
signal item_slot_pressed(item_name, item_ID)
signal hand_error(description)

var item_name = null
var item_number = null
var item_path = null
var is_used = false
var rng = RandomNumberGenerator.new()


func set_item(new_item, item_ID):
	item_number = item_ID
	item_path = Equipment._return_texture_name(new_item)
	item_name = Equipment._return_name(new_item)
	self.texture_normal = load(item_path)	
	self.rotation = deg_to_rad(rng.randi_range(0, 360))
	self.scale.x = 10
	self.scale.y = 10
	var bitmap = BitMap.new()
	bitmap.create_from_image_alpha(self.texture_normal.get_image())
	texture_click_mask = bitmap
	

func _on_pressed() -> void:
	if not is_used:
		if Equipment.tapes == 0 and Hand.length > 0:
			emit_signal("hand_error", "you don't have enough tapes!")
			return
		if Hand.get_child_count() > 0 and Equipment._return_type(Hand.get_child(Hand.get_child_count() - 1)._name) == 2:
			emit_signal("hand_error", "the hand has an ending item already!")
			return
		emit_signal("item_slot_pressed", item_name, item_number)
		is_used = true
		self.set_modulate(Color(0.5, 0.5, 0.5))
  

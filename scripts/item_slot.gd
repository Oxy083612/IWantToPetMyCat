extends TextureButton

signal item_slot_pressed(item_name)

var item_name = null
var item_path = null
var is_used = false
var rng = RandomNumberGenerator.new()
	
#dostaje id do itema który już nie istnieje/nie jest na scenie
func set_item(new_item):
	item_path = Equipment._return_texture_name(new_item)
	item_name = Equipment._return_name(new_item)
	self.texture_normal = load(item_path)	
	self.rotation = deg_to_rad(rng.randi_range(0, 360))
	self.scale.x = 3
	self.scale.y = 3
	var bitmap = BitMap.new()
	bitmap.create_from_image_alpha(self.texture_normal.get_image())
	texture_click_mask = bitmap
	

func _on_pressed() -> void:
	if not is_used:
		emit_signal("item_slot_pressed", item_name)
		if Equipment.tapes == 0:
			return
		self.set_modulate(Color(0.5, 0.5, 0.5))
		Equipment.tapes -= 1
		is_used = true
	else:
		self.set_modulate(Color(1, 1, 1))
		Equipment.tapes += 1
		is_used = false

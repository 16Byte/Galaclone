extends Node

var bounds : Rect2

func initialize(camera: Camera2D, viewport_rect: Rect2) -> void:
	var center = camera.get_screen_center_position()
	var half_w = viewport_rect.size.x / (2.0 * camera.zoom.x)
	var half_h = viewport_rect.size.y / (2.0 * camera.zoom.y)
	bounds = Rect2(center.x - half_w, center.y - half_h, half_w * 2.0, half_h * 2.0)
	
func get_spawn_x() -> float:
	# Random X anywhere in play area with margin
	return randf_range(bounds.position.x + 16.0, bounds.end.x - 16.0)
	
func get_spawn_y() -> float:
	return bounds.position.y - 32.0
	
func is_out_of_bounds(pos: Vector2) -> bool:
	return not bounds.grow(32.0).has_point(pos)

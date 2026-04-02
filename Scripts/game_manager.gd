extends Node

func _ready() -> void:
	await get_tree().process_frame
	PlayArea.initialize(get_tree().root.get_camera_2d(), get_tree().root.get_visible_rect())

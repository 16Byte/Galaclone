extends CharacterBody2D

@export var speed: float = 200.0
@export var bottom_offset: float = 40.0
@export var side_margin: float = 16.0
@export var fire_position_offset: float = 5.0

@onready var camera: Camera2D = $"../Camera"  # adjust path to your cam
@onready var projectile = preload("res://Scenes/projectile.tscn")

var screen_size: Vector2

func get_screen_bounds() -> Rect2:
	var viewport_rect = get_viewport_rect()
	var center = camera.get_screen_center_position()
	var half_w = viewport_rect.size.x / (2.0 * camera.zoom.x)
	var half_h = viewport_rect.size.y / (2.0 * camera.zoom.y)
	return Rect2(center.x - half_w, center.y - half_h, half_w * 2.0, half_h * 2.0)

func _ready() -> void:
	await get_tree().process_frame
	var bounds = get_screen_bounds()
	position.x = bounds.get_center().x
	position.y = bounds.end.y - bottom_offset

func _physics_process(delta: float) -> void:
	var bounds = get_screen_bounds()
	
	# firing logic
	if Input.is_action_just_pressed("ui_down"):
		var projectile_temp = projectile.instantiate()
		projectile_temp.direction = -1
		projectile_temp.position = Vector2(position.x, position.y - fire_position_offset)
		get_tree().root.add_child(projectile_temp)
		print("fired projectile")
	
	var input_dir: float = Input.get_axis("ui_left", "ui_right")
	velocity.x = input_dir * speed
	velocity.y = 0.0
	
	move_and_slide()
	
	position.x = clamp(position.x, bounds.position.x + side_margin, bounds.end.x - side_margin)
	position.y = bounds.end.y - bottom_offset

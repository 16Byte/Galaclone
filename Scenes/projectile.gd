extends Area2D

var speed = 300
var direction = 1

@export var sprite: Sprite2D

func _ready() -> void:
	sprite.flip_v = true if direction == -1 else false

func _process(delta: float) -> void:
	position.y += speed * direction * delta

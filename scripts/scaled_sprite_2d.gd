@tool
class_name ScaledSprite2D
extends Sprite2D

@export var sprite_scale: float = 150.0:
	set(value):
		sprite_scale = value
		var temp_scale = sprite_scale / texture.get_height()
		scale = Vector2(temp_scale, temp_scale)

func _ready() -> void:
	var temp_scale = sprite_scale / texture.get_height()
	scale = Vector2(temp_scale, temp_scale)

class_name Hero
extends Node2D

@export_range(1, 4) var hero_size: int = 1
@export var hero_texture: Texture2D

@onready var hero_sprite: Sprite2D = %HeroSprite
@onready var mouse_hover: Area2D = %MouseHoverArea

var hover_tween: Tween

func _ready() -> void:
	mouse_hover.mouse_entered.connect(func():
		z_index += 1
		tween_effect(175))
	mouse_hover.mouse_exited.connect(func():
		z_index -= 1
		tween_effect(150))
	
	hero_sprite.texture = hero_texture
	
	if get_parent() is HeroTeam:
		if get_parent().team_type == HeroTeam.TeamType.ENEMY:
			hero_sprite.flip_h = true
		else:
			hero_sprite.flip_h = false

func tween_effect(scale: float) -> void:
	if hover_tween:
		hover_tween.kill()
	hover_tween = get_tree().create_tween()
	hover_tween.tween_property(hero_sprite, "sprite_scale", scale, 0.125).set_ease(Tween.EASE_IN_OUT)

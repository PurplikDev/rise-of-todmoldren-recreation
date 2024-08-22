class_name HeroCharacter
extends Node2D

signal hero_hovered(hero: HeroCharacter)
signal hero_hover_exited(hero: HeroCharacter)
signal hero_selected(hero: HeroCharacter)

@export_range(1, 4) var hero_size: int = 1
@export var hero_texture: Texture2D

@onready var hero_sprite: Sprite2D = %HeroSprite
@onready var mouse_hover: Area2D = %MouseHoverArea

var hover_tween: Tween
var is_hovered: bool = false

func _input(event: InputEvent) -> void:
	if is_hovered && event is InputEventMouseButton && event.is_pressed():
		hero_selected.emit(self)

func _ready() -> void:
	mouse_hover.mouse_entered.connect(func():
		z_index += 1
		tween_effect(175)
		hero_hovered.emit(self)
		is_hovered = true)
	mouse_hover.mouse_exited.connect(func():
		z_index -= 1
		tween_effect(150)
		hero_hover_exited.emit(self)
		is_hovered = false)
	
	hero_sprite.texture = hero_texture
	
	if get_parent() is HeroTeam:
		if get_parent().team_type == HeroTeam.TeamType.ENEMY:
			hero_sprite.flip_h = true
		else:
			hero_sprite.flip_h = false

func tween_effect(new_scale: float) -> void:
	if hover_tween:
		hover_tween.kill()
	hover_tween = get_tree().create_tween()
	hover_tween.tween_property(hero_sprite, "sprite_scale", new_scale, 0.125).set_ease(Tween.EASE_IN_OUT)

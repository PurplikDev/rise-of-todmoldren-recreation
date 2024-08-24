class_name HeroCharacter
extends Node2D

signal hero_hovered(hero: HeroCharacter)
signal hero_hover_exited(hero: HeroCharacter)
signal hero_selected(hero: HeroCharacter)

const CORPSE = preload("res://resources/heroes/corpse.tres")

@export var hero: Hero:
	set(value):
		hero = value
		%HeroSprite.texture = hero.texture
		%HealthBar.max_value = hero.health
		%HealthBar.value = hero.health

@onready var hero_sprite: TextureRect = %HeroSprite
@onready var mouse_hover: Area2D = %MouseHoverArea
@onready var health_bar: ProgressBar = %HealthBar

@onready var health: int = hero.health:
	set(value):
		if value < 1:
			if hero != CORPSE:
				spawn_corpse()
			else:
				queue_free()
		elif value >= hero.health:
			health = hero.health
		else:
			health = value
			health_bar.value = value

var hover_tween: Tween
var health_bar_tween: Tween
var is_hovered: bool = false

func _input(event: InputEvent) -> void:
	if is_hovered && event is InputEventMouseButton && event.is_pressed():
		hero_selected.emit(self)

func _ready() -> void:
	mouse_hover.mouse_entered.connect(func():
		z_index += 1
		tween_effect(Vector2(1.0625, 1.0625))
		hero_hovered.emit(self)
		is_hovered = true)
	mouse_hover.mouse_exited.connect(func():
		z_index -= 1
		tween_effect(Vector2(1, 1))
		hero_hover_exited.emit(self)
		is_hovered = false)
	
	if get_parent() is HeroTeam:
		if get_parent().team_type == HeroTeam.TeamType.ENEMY:
			hero_sprite.flip_h = true
		else:
			hero_sprite.flip_h = false

func tween_effect(new_scale: Vector2) -> void:
	if hover_tween:
		hover_tween.kill()
	hover_tween = get_tree().create_tween()
	hover_tween.tween_property(hero_sprite, "scale", new_scale, 0.125).set_ease(Tween.EASE_IN_OUT)
 
func spawn_corpse():
	hero = CORPSE
	health = CORPSE.health
	health_bar.max_value = health
	health_bar.value = health

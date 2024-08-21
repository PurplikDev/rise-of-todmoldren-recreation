class_name Hero
extends Node2D

@export_range(1, 4) var hero_size: int = 1

@onready var hero_sprite: Sprite2D = %HeroSprite
@onready var mouse_hover: Area2D = %MouseHoverArea

func _ready() -> void:
	mouse_hover.mouse_entered.connect(func(): 
		z_index += 1 
		print("fdsfsfdsfs"))
	mouse_hover.mouse_exited.connect(func(): z_index -= 1 )

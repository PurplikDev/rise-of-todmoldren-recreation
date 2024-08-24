class_name Hero
extends Resource

@export var name: String = "Hero"

# sprite stuff here?

@export var texture: Texture2D

@export_range(1, 4) var hero_size: int = 1

@export var attack: Action

# attacks array?

@export_category("Stats")
@export var health: int = 25
@export var defence: int = 10
@export var speed: int = 5
# no random generation, handcrafted characters :3

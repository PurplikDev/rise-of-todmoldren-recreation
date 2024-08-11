extends Node

@export var character: Character
@export var dungeon: Dungeon

@onready var chest_button = %ChestButton

func _ready():
	chest_button.pressed.connect(func():
		character.health_potion += 1
		chest_button.visible = false
		)
	dungeon.chest_spawned.connect(chest_spawn)

func chest_spawn():
	chest_button.visible = true

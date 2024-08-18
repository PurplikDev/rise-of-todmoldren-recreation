class_name Combat
extends Node

@export var character: Character
@export var dungeon: Dungeon

@onready var combat_screen = %CombatScreen
@onready var enemy = %Enemy

var enemy_health: int

func _ready():
	dungeon.combat_started.connect(start_combat)
	enemy.pressed.connect(attack)

func start_combat():
	enemy_health = randi_range(25, 50)
	combat_screen.visible = true

func end_combat():
	dungeon.unlock_buttons()
	combat_screen.visible = false

func attack():
	enemy_health -= randi_range(1 + character.level, 10 + character.level)
	
	if enemy_health > 0:
		if character.defence_boost:
			character.damage(randi_range(1, 8))
		else:
			character.damage(randi_range(1, 15))
	else:
		character.money += randi_range(1, 8)
		character.xp += randi_range(5, 25)
		character.health_potion += 1
		end_combat()

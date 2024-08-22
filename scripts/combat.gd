class_name Combat
extends Node

@onready var player_team: HeroTeam = %PlayerTeam
@onready var enemy_team: HeroTeam = %EnemyTeam

var heroes: Array[Hero]
var turn_order

func _ready() -> void:
	start_combat()

func start_combat() -> void:
	pass
	# spawn_enemies()
	
	for player_hero in player_team.get_children():
		player_hero.hero_hovered.connect(display_hero_player)
	
	for enemy_hero in enemy_team.get_children():
		enemy_hero.hero_hovered.connect(display_hero_enemy)
	
	new_turn()

func new_turn() -> void:
	pass

func display_hero_player(hero: Hero) -> void:
	print(str("player ", hero.name))

func display_hero_enemy(hero: Hero) -> void:
	print(str("enemy ", hero.name))

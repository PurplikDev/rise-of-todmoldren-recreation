class_name Combat
extends Node

@onready var player_team: HeroTeam = %PlayerTeam
@onready var enemy_team: HeroTeam = %EnemyTeam

# player ui stuff

@onready var player_hero_name: Label = %PlayerHeroName
@onready var player_hero_health_display: Label = %PlayerHeroHealthDisplay
@onready var player_hero_defence_display: Label = %PlayerHeroDefenceDisplay
@onready var player_hero_speed_display: Label = %PlayerHeroSpeedDisplay

# enemy ui stuff

@onready var enemy_hero_name: Label = %EnemyHeroName
@onready var enemy_hero_health_display: Label = %EnemyHeroHealthDisplay
@onready var enemy_hero_defence_display: Label = %EnemyHeroDefenceDisplay
@onready var enemy_hero_speed_display: Label = %EnemyHeroSpeedDisplay


var heroes: Array[HeroCharacter]
var turn_order
var attacks # dictionary { hero_character, intend (object of an attack and target) }

func _ready() -> void:
	start_combat()

func start_combat() -> void:
	pass
	# spawn_enemies()
	
	for player_hero in player_team.get_children():
		player_hero.hero_selected.connect(display_hero_player)
		heroes.append(player_hero)
	
	for enemy_hero in enemy_team.get_children():
		enemy_hero.hero_selected.connect(display_hero_enemy)
		heroes.append(enemy_hero)
	
	display_hero_player(player_team.get_child(0))
	display_hero_enemy(enemy_team.get_child(0))
	
	new_turn()

func new_turn() -> void:
	
	# pick turns
	
	for hero in heroes:
		print(hero)

func display_hero_player(hero: HeroCharacter) -> void:
	player_hero_name.text = hero.hero.name
	player_hero_health_display.text = str(hero.health)
	player_hero_defence_display.text = str(hero.hero.defence)
	player_hero_speed_display.text = str(hero.hero.speed)

func display_hero_enemy(hero: HeroCharacter) -> void:
	
	hero.health -= 5
	
	enemy_hero_name.text = hero.hero.name
	enemy_hero_health_display.text = str(hero.health)
	enemy_hero_defence_display.text = str(hero.hero.defence)
	enemy_hero_speed_display.text = str(hero.hero.speed)

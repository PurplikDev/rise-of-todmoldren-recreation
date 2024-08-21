@tool
class_name HeroTeam
extends Node2D

const HERO_SPACING: float = 75.0

enum TeamType { PLAYER, ENEMY }

@export var team_type: TeamType:
	set(value):
		team_type = value
		if value == TeamType.PLAYER:
			team_direction = -1
		else:
			team_direction = 1

var team_direction: int = -1

func _ready() -> void:
	child_entered_tree.connect(organize_team)
	child_exiting_tree.connect(organize_team)
	child_order_changed.connect(func(): organize_team(self)) # doing this just to stop an annoying error

func organize_team(_node) -> void:
	for child: Node2D in get_children():
		print(str(child.name, " | ", child.get_index()))
		child.global_position = Vector2(global_position.x + (HERO_SPACING * child.get_index() * team_direction), global_position.y)

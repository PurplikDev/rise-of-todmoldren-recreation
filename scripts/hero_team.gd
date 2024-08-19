@tool
extends Node2D

const HERO_SPACING: float = 150.0

@export var team_type: TeamType

enum TeamType { PLAYER = 1, ENEMY = -1 }

func _ready() -> void:
	child_entered_tree.connect(organize_team)
	child_exiting_tree.connect(organize_team)
	child_order_changed.connect(func(): organize_team(self)) # doing this just to stop an annoying error

func organize_team(node) -> void:
	for child: Node2D in get_children():
		print(str(child.name, " | ", child.get_index()))
		child.global_position = Vector2(global_position.x + HERO_SPACING * child.get_index(), global_position.y)

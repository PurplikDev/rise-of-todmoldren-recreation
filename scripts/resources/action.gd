@tool
class_name Action
extends Resource

@export var action_name: String
@export var action_targets_enemy: Array[int]
@export var target_group: Target

@export_category("Positioning")
@export var perform_positions: String = "----":
	set(value):
		if value.length() == 4:
			perform_positions = value
			print(perform_positions)

enum Target { PERFORMER, ENEMY, PERFORMER_GROUP, ENEMY_GROUP }

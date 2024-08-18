class_name PathOptionButton
extends Button

@export var path_icon: TextureRect

var ticks: float
var path_to: Dungeon.RoomType:
	set(value):
		path_to = value
		match value:
			Dungeon.RoomType.COMBAT: path_icon.texture = load("res://assets/icons/combat.png")
			Dungeon.RoomType.CHEST: path_icon.texture = load("res://assets/icons/chest.png")
			_: path_icon.texture = null
		
		path_icon.visible = !disabled

func _process(delta):
	if is_hovered():
		ticks += delta * 2.5
		rotation_degrees = sin(ticks) * 5
	else:
		rotation_degrees = 0

func update_icon_visibility():
	path_icon.visible = !disabled

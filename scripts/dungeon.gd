class_name Dungeon
extends Node

signal combat_started
signal chest_spawned

@onready var dungeon_background = %DungeonBackground
@onready var left_button = %LeftButton
@onready var up_button = %UpButton
@onready var right_button = %RightButton

@onready var color_screen = %ColorScreen

@export var forest_pieces: Array[DungeonPiece]
@export var cave_pieces: Array[DungeonPiece]

var current_piece: DungeonPiece

enum RoomType { EMPTY, COMBAT, CHEST }

func _ready():
	left_button.pressed.connect(proceed_dungeon.bind(left_button))
	up_button.pressed.connect(proceed_dungeon.bind(up_button))
	right_button.pressed.connect(proceed_dungeon.bind(right_button))
	
	combat_started.connect(lock_buttons)
	
	current_piece = forest_pieces.pick_random()
	update_interface()

func proceed_dungeon(button: PathOptionButton):
	var transition_tween = get_tree().create_tween()
	transition_tween.tween_property(color_screen, "self_modulate", Color(1.0, 1.0, 1.0, 1.0), 0.5)
	transition_tween.tween_callback(func(): change_location(button.path_to))

func change_location(_room_type: RoomType):
	current_piece = forest_pieces.pick_random()
	
	unlock_buttons()
	
	update_interface()
	var transition_tween = get_tree().create_tween()
	transition_tween.tween_property(color_screen, "self_modulate", Color(1.0, 1.0, 1.0, 0.0), 0.5)

func update_interface():
	dungeon_background.texture = current_piece.piece_texture
	generate_options()

func generate_options():
	left_button.path_to = random_room_type()
	up_button.path_to = random_room_type()
	right_button.path_to = random_room_type()

func lock_buttons():
	left_button.disabled = true
	up_button.disabled = true
	right_button.disabled = true

func unlock_buttons():
	left_button.disabled = !current_piece.left
	up_button.disabled = !current_piece.up
	right_button.disabled = !current_piece.right
	
	left_button.update_icon_visibility()
	up_button.update_icon_visibility()
	right_button.update_icon_visibility()

func random_room_type() -> RoomType:
	var index = randi_range(0, 2)
	
	match index:
		0: return RoomType.EMPTY
		1: return RoomType.COMBAT
		2: return RoomType.CHEST
	return RoomType.EMPTY

class_name Dungeon
extends Node

signal combat_started
signal chest_spawned

@onready var dungeon_background = %DungeonBackground
@onready var left_button = %LeftButton
@onready var up_button = %UpButton
@onready var right_button = %RightButton

@export var forest_pieces: Array[DungeonPiece]
@export var cave_pieces: Array[DungeonPiece]

var current_piece: DungeonPiece
var is_cave: bool = false

func _ready():
	left_button.pressed.connect(proceed_dungeon)
	up_button.pressed.connect(proceed_dungeon)
	right_button.pressed.connect(proceed_dungeon)
	
	current_piece = forest_pieces.pick_random()
	update_interface()
	unlock_buttons()

func proceed_dungeon():
	if current_piece.is_transition:
		is_cave = !is_cave
	
	if is_cave:
		current_piece = cave_pieces.pick_random()
	else:
		current_piece = forest_pieces.pick_random()
	
	if randi_range(0, 5) == 3:
		combat_started.emit()
		lock_buttons()
	else:
		unlock_buttons()
	
	if randi_range(0, 3) == 1:
		chest_spawned.emit()
		print("chest!")
	
	update_interface()

func update_interface():
	dungeon_background.texture = current_piece.piece_texture

func lock_buttons():
	left_button.disabled = true
	up_button.disabled = true
	right_button.disabled = true

func unlock_buttons():
	left_button.disabled = !current_piece.left
	up_button.disabled = !current_piece.up
	right_button.disabled = !current_piece.right

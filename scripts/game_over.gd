extends Node

@onready var canvas_layer = %CanvasLayer

@onready var quit_button = %QuitButton
@onready var restard_button = %RestardButton

func _ready():
	quit_button.pressed.connect(func(): get_tree().quit())
	restard_button.pressed.connect(func(): get_tree().change_scene_to_file("res://game.tscn"))

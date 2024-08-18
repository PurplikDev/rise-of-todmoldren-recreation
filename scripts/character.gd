class_name Character
extends Node

signal died

@onready var health_display: ProgressBar = %HealthDisplay

var status_effects: Array

var max_health: int
var health: int:
	set(value):
		if value >= max_health:
			health = max_health
		elif  value <= 0:
			died.emit()
		
		health = value
		
		health_display.value = health
		# emit signal/update ui

func _ready() -> void:
	health_display.max_value = max_health
	health_display.value = health

func damage(amount: int):
	# insert damage calculation here
	health -= amount

func heal(amount: int):
	health += amount

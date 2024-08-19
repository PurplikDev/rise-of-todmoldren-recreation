class_name Character
extends Node

signal died

var status_effects: Array

var max_health: int
var health: int:
	set(value):
		if value >= max_health:
			health = max_health
		elif  value <= 0:
			died.emit()
		
		health = value
		
		# emit signal/update ui

func damage(amount: int):
	# insert damage calculation here
	health -= amount

func heal(amount: int):
	health += amount

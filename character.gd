class_name Character
extends Node

@onready var health_potion_button = %HealthPotionButton
@onready var health_potion_amount = %HealthPotionAmount
@onready var health_display = %HealthDisplay

var character_name: String = "Hero"
var max_health: int = 100
var health: int = 100:
	set(value):
		health = value
		health_display.text = str(health)

var level_cap: int = 50
var level: int = 1
var xp: int = 0

var attack_boost: bool
var defence_boost: bool

var money: int
var health_potion: int = 3:
	set(value):
		health_potion = value
		if health_potion > 0:
			health_potion_button.disabled = false
		else:
			health_potion_button.disabled = true
		health_potion_amount.text = str(health_potion)

func _ready():
	health_potion_button.pressed.connect(use_potion)
	health_potion_amount.text = str(health_potion)
	health_display.text = str(health)

func damage(amount: int):
	print("ouch! | ", amount)
	health -= amount
	print("i have ", health, " health left!")
	if health <= 0:
		print("end of game!!!")
		%CanvasLayer.visible = true

func heal(amount: int):
	health = clampi(health + amount, 0, max_health)

func gain_xp(amount: int):
	xp += amount
	if xp > level_cap:
		xp -= level_cap
		level_cap += 50
		level += 1
		print_rich("[wave][rainbow]level up![/rainbow][/wave]")

func use_potion():
	health_potion -= 1
	heal(10)

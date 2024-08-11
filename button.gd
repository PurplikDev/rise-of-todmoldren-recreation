extends Button

var is_hovered: bool = false
var ticks: float

# Called when the node enters the scene tree for the first time.
func _ready():
	mouse_entered.connect(func(): is_hovered = true)
	mouse_exited.connect(func(): is_hovered = false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_hovered:
		ticks += delta * 2.5
		rotation_degrees = sin(ticks) * 5
	else:
		rotation_degrees = 0

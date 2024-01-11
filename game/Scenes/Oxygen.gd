extends CanvasLayer

@onready var oxygen_tank = $Control/MarginContainer/HBoxContainer/MarginContainer/OxygenTank


var oxygen_level = 100:
	set(new_oxygen_level):
		oxygen_level = new_oxygen_level
		update_oxygen()
func update_oxygen():
	oxygen_tank.value = oxygen_level


# Called when the node enters the scene tree for the first time.
func _ready():
	update_oxygen()
	pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print("oxygen level: ", oxygen_level)
	if oxygen_level <= 0:
		#death
		pass
	#if hit my astroid:
	#recieve x amount of damange
	oxygen_level -= 0.1 * delta
	pass

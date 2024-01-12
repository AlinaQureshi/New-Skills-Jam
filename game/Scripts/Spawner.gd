extends Node3D

func spawn_ProjCopies():
	var  Projectile = load("res://Scenes/Level/astroid.tscn")
	var ProjCopies = Projectile.instantiate()
	var minRange = 7
	var maxRange = 10
	var num = 5
	var location =Vector3()
	var rotationP = Vector3()

	location.x = randi() % num #randi_range(minRange,maxRange)
	location.y =randi_range(minRange,maxRange) 
	location.z = randi() % num #randi_range(minRange,maxRange) 
	rotationP.x= randi_range(0,360)
	rotationP.y= randi_range(0,360)
	rotationP.z= randi_range(0,360)
	
	add_child(ProjCopies)
	ProjCopies.global_position = location
	ProjCopies.rotation_degrees = rotationP
	


func _on_timer_timeout():
	spawn_ProjCopies()

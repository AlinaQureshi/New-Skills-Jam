extends Node3D

@onready var HitCollision = $RigidBody3D/Area3D





func _on_area_3d_area_entered(area):
	if area.is_in_group("Ground"):
		await get_tree().create_timer(2).timeout
		get_node("Destruction").destroy()

	if area.is_in_group("Player"):
		print("----------game over---------")

func _on_timer_timeout():
	queue_free()


func _on_area_3d_body_entered(body):
	if body.name.begins_with("Player"):
		print("----------game over---------") 
	
	

	




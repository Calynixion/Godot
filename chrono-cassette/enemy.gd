extends CharacterBody2D

@onready var ray_cast1 = $RayCast2D1
@onready var ray_cast2 = $RayCast2D2
@onready var ray_cast3 = $RayCast2D3
@onready var ray_cast4 = $RayCast2D4
@onready var area_2d = $Area2D

#follow path
#if distraction then save point on path and go to distraction
#then go back to point on path

func _process(delta):
	if ray_cast1.is_colliding():
		print("raycast 1 collide")
	if ray_cast2.is_colliding():
		print("raycast 2 collide")
	if ray_cast3.is_colliding():
		print("raycast 3 collide")
	if ray_cast4.is_colliding():
		print("raycast 4 collide")
		
	
func _on_area_2d_area_entered(area):
	print("area entered")

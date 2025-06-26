extends CharacterBody2D

@onready var ray_cast1 = $RayCast2D1
@onready var ray_cast2 = $RayCast2D2
@onready var ray_cast3 = $RayCast2D3
@onready var ray_cast4 = $RayCast2D4
@onready var ray_cast5 = $RayCast2D5

#follow path
#if distraction then save point on path and go to distraction
#then go back to point on path

func _ready():
	position.y = 166
#func _ready():
	


func _process(delta):
	if ray_cast1.is_colliding():
		print(ray_cast1.get_collider().position)
		if ray_cast1.get_collider().name == "player":
			
			#velocity = (ray_cast1.get_collider().position - position).normalized() * 1000 * delta
		if ray_cast1.get_collider().name == "player":			
			rotation += -5 * delta
			velocity = (ray_cast1.target_position).normalized().rotated(rotation) * 400 * delta
			move_and_slide()
	#if ray_cast2.is_colliding():
		#print("raycast 2 collide")
	#if ray_cast3.is_colliding():
		#print("raycast 3 collide")
	#if ray_cast4.is_colliding():
		#print("raycast 4 collide")
	#testtesttest
	if ray_cast2.is_colliding():
		if ray_cast2.get_collider().name == "player":
			rotation += -2 * delta
			velocity = (ray_cast2.target_position).normalized().rotated(rotation) * 400 * delta
			move_and_slide()
	if ray_cast3.is_colliding():
		if ray_cast3.get_collider().name == "player":
			rotation += 2 * delta
			velocity = (ray_cast3.target_position).normalized().rotated(rotation) * 400 * delta
			move_and_slide()
	if ray_cast4.is_colliding():
		if ray_cast4.get_collider().name == "player":
			rotation += 5 * delta
			velocity = (ray_cast4.target_position).normalized().rotated(rotation) * 400 * delta
			move_and_slide()
	if ray_cast5.is_colliding():
		if ray_cast5.get_collider().name == "player":
			velocity = (ray_cast5.target_position).normalized().rotated(rotation) * 400 * delta
			move_and_slide()
		
		

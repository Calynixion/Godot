extends CharacterBody2D


@onready var main = get_tree().get_first_node_in_group("main")
@onready var ray_cast1 = $RayCast2D1
@onready var ray_cast2 = $RayCast2D2
@onready var ray_cast3 = $RayCast2D3
@onready var ray_cast4 = $RayCast2D4
@onready var ray_cast5 = $RayCast2D5




#follow path
#if distraction then save point on path and go to distraction
#then go back to point on path

	
#func _ready():
	#if get_tree().get_first_node_in_group("main") == null:
		#pass
	#else:
		#var overscrn = get_tree().get_first_node_in_group("main")
		

func _process(delta):
	if ray_cast1.is_colliding():
		if ray_cast1.get_collider().name == "player":			
			caught()
			#rotation += -5 * delta
			#velocity = (ray_cast1.target_position).normalized().rotated(rotation) * 4000 * delta
			move_and_slide()
	if ray_cast2.is_colliding():
		if ray_cast2.get_collider().name == "player":
			caught()
			#rotation += -2 * delta
			#velocity = (ray_cast2.target_position).normalized().rotated(rotation) * 4000 * delta
			move_and_slide()
	if ray_cast3.is_colliding():
		if ray_cast3.get_collider().name == "player":
			caught()
			#rotation += 2 * delta
			#velocity = (ray_cast3.target_position).normalized().rotated(rotation) * 4000 * delta
			move_and_slide()
	if ray_cast4.is_colliding():
		if ray_cast4.get_collider().name == "player":
			caught()
			#rotation += 5 * delta
			#velocity = (ray_cast4.target_position).normalized().rotated(rotation) * 4000 * delta
			move_and_slide()
	if ray_cast5.is_colliding():
		if ray_cast5.get_collider().name == "player":
			caught()
			#velocity = (ray_cast5.target_position).normalized().rotated(rotation) * 4000 * delta
			move_and_slide()
			
func caught():
	main.gameovernow()
		

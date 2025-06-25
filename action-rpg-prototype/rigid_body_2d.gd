extends RigidBody2D

#@onready var target = get_tree().get_node("player")
@onready var target = get_tree().get_first_node_in_group("Targets") 
const speed = 10

func _physics_process(delta):
	if target==null:
		pass
	else:
		add_constant_force((target.position - position).normalized() * delta * speed)
		
	

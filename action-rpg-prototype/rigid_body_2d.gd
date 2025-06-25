extends RigidBody2D

#@onready var target = get_tree().get_node("player")
@onready var target = get_tree().get_first_node_in_group("Targets") 

func _physics_process(delta):
	if target==null:
		pass
	else:
		pass
		
	

extends CharacterBody2D

@onready var target = get_tree().get_first_node_in_group("Targets") 
const speed = 3000

func _physics_process(delta):
	if target==null:
		pass
	else:
		velocity = (target.position - position).normalized() * delta * speed
		move_and_slide()
		

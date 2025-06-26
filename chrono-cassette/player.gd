extends CharacterBody2D


const speed = 300.0


func _physics_process(delta: float) -> void:
	var direction=Input.get_vector("left","right","up","down")
	direction=direction.normalized()
	velocity=direction * speed
	move_and_slide()

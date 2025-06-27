extends CharacterBody2D


const speed = 300.0

func over():
	queue_free() #deletes the player when game is over

func _physics_process(delta: float) -> void:
	var direction=Input.get_vector("left","right","up","down")
	direction=direction.normalized()
	velocity=direction * speed
	move_and_slide()

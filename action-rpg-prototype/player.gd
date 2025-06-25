extends CharacterBody2D
@onready var sprite=get_node("sprite")

var speed = 500

func _physics_process(_delta):
	# setup direction of movement
	var direction = Input.get_vector("left", "right", "up", "down")
	if direction==Vector2(0,0):
		sprite.animation="idle"
	else:
		sprite.play("walk")
	#normalize the directional movement
	direction = direction.normalized()
	# setup the actual movement
	velocity = (direction * speed)
	move_and_slide()

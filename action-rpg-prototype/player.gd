extends CharacterBody2D
@onready var sprite=get_node("sprite")
@onready var dash_cooldown=get_node("dash_cooldown")


var speed = 200
var dash_speed = 1500

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
	if Input.is_action_just_pressed("dash"):
		velocity = (direction * dash_speed)
	else:
		velocity = (direction * speed)
	move_and_slide()

extends CharacterBody2D
@onready var player = get_tree().get_first_node_in_group("player")
const speed = 175

func _physics_process(float)->void:
	var enemyAngle = get_angle_to(player.position)
	velocity=speed*Vector2(cos(enemyAngle), sin(enemyAngle))
	move_and_slide()

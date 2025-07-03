extends CharacterBody2D
@onready var player = get_tree().get_first_node_in_group("player")
@onready var hp_dyn=get_node("hp_dyn")
@onready var i_timer=get_node("i_timer")
@onready var i_indicator=get_node("i_indicator")
@onready var debug=get_node("debug")
const speed = 50
var hp=float(25)
var max_hp=float(25)
var i=false
@export var Goal: Node = null

func _ready() -> void:
	$NavigationAgent2D.target_position = Goal.global_position

func _physics_process(float) -> void:
	$NavigationAgent2D.target_position = Goal.global_position
	if !$NavigationAgent2D.is_target_reached():
		var nav_point_direction = to_local($NavigationAgent2D.get_next_path_position()).normalized()
		velocity = nav_point_direction * speed
		if velocity.x<0:
			$AnimatedSprite2D.flip_h=true
		elif velocity.y>0:
			$AnimatedSprite2D.flip_h=false
		if Default.timestop==false:
			move_and_slide()
	hp_dyn.size.x=24*(hp/max_hp)
	if i_timer.is_stopped()==true:
		i=false
		i_indicator.visible=false
	if hp<=0:
		queue_free()

#func _physics_process(float)->void:
#	var enemyAngle = get_angle_to(player.position)
#	velocity=speed*Vector2(cos(enemyAngle), sin(enemyAngle))
#	rays.rotation=(enemyAngle-(3.141592/2))
#	if Default.timestop==false:
#		move_and_slide()
#	hp_dyn.size.x=24*(hp/max_hp)
#	if i_timer.is_stopped()==true:
#		i=false
#		i_indicator.visible=false
#	if hp<=0:
#		queue_free()
#	debug.text=str(enemyAngle)



func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_bullet"):
		if i==false:
			hp-=5
			i_timer.start(0.0000001)
			i_timer.one_shot=true
			i=true
			i_indicator.visible=true
		

		


func _on_timer_timeout() -> void:
	if $NavigationAgent2D.target_position != Goal.global_position:
		$NavigationAgent2D.target_position = Goal.global_position
	$PathfindingUpdateTimer.start()

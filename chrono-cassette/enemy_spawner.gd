extends Node2D

@onready var enemy=preload("res://different_enemy.tscn")
var rng = RandomNumberGenerator.new()
var can_spawn=true
@onready var spawn_timer=$timer
@onready var player=get_tree().get_first_node_in_group("player")

func _process(delta: float) -> void:
	if can_spawn==true:
		spawn_enemy()
		can_spawn=false
		spawn_timer.start(rng.randf_range(5,30))
		spawn_timer.one_shot=true
	if spawn_timer.is_stopped()==true:
		can_spawn=true

func spawn_enemy():
	var new_enemy = enemy.instantiate()
	new_enemy.Goal=player
	add_child(new_enemy)
	new_enemy.top_level=true
	new_enemy.global_position=global_position
	new_enemy.add_to_group("enemies")
	

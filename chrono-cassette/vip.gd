extends Node2D
var health = 100
@onready var red=get_node("red")
func _physics_process(delta: float) -> void:
	if health<=0:
		red.visible=true

extends Node2D
@onready var player=get_node("../CharacterBody2D")
@onready var debug=get_node("../debug")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position=get_global_mouse_position()
	debug.text=str(global_position)+str(player.global_position)

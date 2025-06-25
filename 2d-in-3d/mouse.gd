extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position=get_global_mouse_position()

func _draw():
	draw_line(position,Vector2(0,0),Color.GREEN,8.0)

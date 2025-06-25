extends Node2D
@onready var player=get_node("CharacterBody2D")
@onready var mouse=get_node("mouse")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	queue_redraw()

func _draw():
	draw_line(mouse.position,player.position,Color.GREEN,1.0)

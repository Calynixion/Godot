extends Camera2D


@onready var player=get_tree().get_first_node_in_group("player")

func _process(delta: float) -> void:
	position=player.position
	if position.x-160<0:
		position.x=160
	if position.y-120<0:
		position.y=120

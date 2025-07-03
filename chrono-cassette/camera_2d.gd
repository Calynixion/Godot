extends Camera2D


@onready var player=get_tree().get_first_node_in_group("player")

func _process(delta: float) -> void:
	if player!=null:
		position=player.position
		if position.x-160<0:
			position.x=160
		if position.y-120<0:
			position.y=120
		if position.x+160>1264:
			position.x=1104
		if position.y+120>768:
			position.y=648

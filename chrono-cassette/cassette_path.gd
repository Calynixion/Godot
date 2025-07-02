extends Path2D
@onready var pather=get_node("path")
@onready var line=$line
func _on_tester_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body is not CharacterBody2D:
		var player=get_tree().get_first_node_in_group("player")
		player.stop_cassette()

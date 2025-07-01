extends Area2D
var speed=10
var direction=Vector2(1,0)

func _physics_process(delta: float) -> void:
	position+=direction*speed
	if global_position.x<0 or global_position.y<0 or global_position.x>12800 or global_position.y>7200:
		queue_free()


func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body is TileMapLayer or body.is_in_group("enemies"):
		self.queue_free()

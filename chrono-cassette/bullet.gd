extends Area2D
var speed=10
var direction=Vector2(1,0)

func _physics_process(delta: float) -> void:
	position+=direction*speed


func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body is TileMapLayer:
		self.queue_free()

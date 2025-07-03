extends Control
@onready var color_rect = $ColorRect
@onready var player=get_tree().get_first_node_in_group("player")
signal restarted

func _process(delta: float) -> void:
	if player.health>0:
		position=player.position+Vector2(-160,-120)

func gameover(): #called when player dies
	visible = true
	color_rect.reset() #makes the fade away invisible because it will start fading in


func _on_button_pressed():
	visible = false
	restarted.emit()

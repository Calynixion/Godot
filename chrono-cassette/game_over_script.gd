extends Control
@onready var color_rect = $ColorRect

signal restarted

func gameover(): #called when player dies
	visible = true
	color_rect.reset() #makes the fade away invisible because it will start fading in


func _on_button_pressed():
	visible = false
	restarted.emit()
	

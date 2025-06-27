extends Area2D
@onready var label = $Label
@onready var visible_color := Color (255,255,255,255)
@onready var invisible_color := Color (255,255,255,0)
@onready var show := false

func _on_area_entered(area):
	show = true
	
func _on_area_exited(area):
	show = false

func _process(delta):
	if show == true:
		label.modulate = lerp(label.modulate, visible_color, delta*10.0)
	if show == false:
		label.modulate = lerp(label.modulate, invisible_color, delta*100.0)

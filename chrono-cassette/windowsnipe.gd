extends Area2D
@onready var label = $Label
@onready var visible_color := Color (255,255,255,255)
@onready var invisible_color := Color (255,255,255,0)
@onready var playernear := false
@onready var killcontroller = get_tree().get_first_node_in_group("killcontrol")
@onready var sprite = get_node("sprite")
func _on_area_entered(area):
	if area.is_in_group("player"):
		playernear = true
	
	
func _on_area_exited(area):
	if area.is_in_group("player"):
		playernear = false

func _process(delta):
	if playernear == true:
		label.modulate = lerp(label.modulate, visible_color, delta*10.0) #makes text visible
	if playernear == false:
		label.modulate = lerp(label.modulate, invisible_color, delta*100.0) # makes text invisible
	if Input.is_action_just_pressed("interact") and playernear:
		killcontroller.get_node("sniper_timer").stop()
		sprite.animation="close"

extends ColorRect

var color_ = Color(0,0,0,255)
func _process(delta):
	# smoothly tweens alpha to be higher to fade away the level
	color = color.lerp(color_, delta * .01)

func reset():
	#makes this invisible
	color = Color(0,0,0,0)

extends PathFollow2D

var speed = 0.1

func _process(delta):
	progress_ratio += delta * speed #update this since it moves by length of track meaning shorter tracks make this move faster

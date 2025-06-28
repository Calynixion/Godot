extends CharacterBody2D
@onready var cassette_path=$cassette_path
@onready var record_timer=get_node("record_timer")
const speed = 100.0
var recording=false
func over():
	queue_free() #deletes the player when game is over

func _physics_process(delta: float) -> void:
	var direction=Input.get_vector("left","right","up","down")
	direction=direction.normalized()
	velocity=direction * speed
	if Input.is_action_just_pressed("record_cassette"):
		record_timer.start(3)
		record_timer.one_shot=true
		recording=true
		cassette_path.curve.clear_points()
	if record_timer.is_stopped()==true:
		recording=false
	elif recording==true:
		record_cassette()
	move_and_slide()

func record_cassette():
	cassette_path.curve.add_point(Vector2(1,1))

func play_cassette():
	pass

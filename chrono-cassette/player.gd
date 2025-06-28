extends CharacterBody2D
@onready var cassette_path=get_tree().get_first_node_in_group("path")
@onready var record_timer=get_node("record_timer")
const speed = 300.0
var recording=false
var cassette_length=90
@onready var debug=get_node("debug")
func over():
	queue_free() #deletes the player when game is over


func _physics_process(delta: float) -> void:
	var direction=Input.get_vector("left","right","up","down")
	direction=direction.normalized()
	velocity=direction * speed
	if Input.is_action_just_pressed("record_cassette"):
		record_timer.start(cassette_length)
		record_timer.one_shot=true
		recording=true
		cassette_path.curve.clear_points()
	if record_timer.is_stopped()==true:
		recording=false
		debug.text=""
	elif recording==true:
		record_cassette()
	move_and_slide()

func record_cassette():
	cassette_path.curve.add_point(position)
	debug.text="active"+str(position)+str(cassette_path.global_position)

func play_cassette():
	pass

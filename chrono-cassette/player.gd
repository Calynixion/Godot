extends CharacterBody2D
@onready var cassette_path=get_tree().get_first_node_in_group("path")
@onready var record_timer=get_node("record_timer")
@onready var follow=cassette_path.get_node("path")
const speed = 150.0
var recording=false
var cassette_length=2
var held_path=false
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
		record_timer.paused=false
		recording=true
		held_path=false
		cassette_path.curve.clear_points()
		cassette_path.position=Vector2(0,0)
		debug.text=str(cassette_path.position)+str(cassette_path.curve.point_count)
	if record_timer.time_left<=0:
		if recording==true:
			#debug.text=""
			held_path=true
			record_timer.start(cassette_length)
			record_timer.paused=true
			var offset=position-cassette_path.curve.get_point_position(0)
			cassette_path.position+=offset
		recording=false
	elif held_path==true:
		#function to move path to player position
		cassette_path.position+=((direction*speed)/60)
		#debug.text="moving"
	elif recording==true and direction!=Vector2(0,0):
		record_cassette()
	if Input.is_action_just_pressed("play_cassette") and recording==false:
		play_cassette()
	move_and_slide()

func record_cassette():
	cassette_path.curve.add_point(position)
	#debug.text="active"

func play_cassette():
	follow.progress=50

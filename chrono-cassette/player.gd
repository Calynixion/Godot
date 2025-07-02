extends CharacterBody2D
@onready var cassette_path=get_tree().get_first_node_in_group("path")
@onready var record_timer=get_node("record_timer")
@onready var follow=cassette_path.get_node("path")
const speed = 150.0
var recording=false
var cassette_length=5
var held_path=false
var play_speed=2
var play_progress=0
var playing=false
var path_len=0
var lockout=false
var mouse_pos=null
var bullet=preload("res://bullet.tscn")
@onready var debug=get_node("debug")
@onready var gun=get_node("gun")
func over():
	queue_free() #deletes the player when game is over


func _physics_process(delta: float) -> void:
	mouse_pos=get_global_mouse_position()
	var direction=Input.get_vector("left","right","up","down")
	direction=direction.normalized()
	velocity=direction * speed
	var old_pos=position
	if lockout==false:
		move_and_slide()
	if Input.is_action_just_pressed("attack"):
		shoot()
	if Input.is_action_just_pressed("record_cassette"):
		record_timer.start(cassette_length)
		record_timer.one_shot=true
		record_timer.paused=false
		recording=true
		held_path=false
		cassette_path.curve.clear_points()
		cassette_path.position=Vector2(0,0)
		debug.text=str(cassette_path.position)+str(cassette_path.curve.point_count)
		playing=false
		play_progress=0
		follow.progress=0
		lockout=false
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
		#cassette_path.position+=((direction*speed)/60)
		cassette_path.position+=position-old_pos
		#debug.text="moving"
	elif recording==true and direction!=Vector2(0,0):
		record_cassette()
	if Input.is_action_just_pressed("play_cassette") and recording==false:
		play_cassette()
	if playing==true:
		play_progress+=play_speed
		global_position=follow.global_position
		Default.timestop=true
		if play_progress>=path_len:
			playing=false
			lockout=false
			cassette_path.position=Vector2(0,0)
			var offset=position-cassette_path.curve.get_point_position(0)
			cassette_path.position+=offset
			Default.timestop=false
		else:
			follow.progress+=play_speed
	debug.text=str(Default.timestop)
	queue_redraw()
	gun.rotation=get_angle_to(get_global_mouse_position())-(3.141592/2)
	

func record_cassette():
	cassette_path.curve.add_point(position)
	#debug.text="active"

func play_cassette():
	if playing==false and cassette_path.curve.point_count!=0:
		playing=true
		path_len=cassette_path.curve.get_baked_length()
		play_progress=0
		follow.progress=0
		lockout=true
		Default.timestop=true
	else:
		playing=false
		path_len=0
		play_progress=0
		follow.progress=0
		lockout=false
		cassette_path.position=Vector2(0,0)
		var offset=position-cassette_path.curve.get_point_position(0)
		cassette_path.position+=offset
		Default.timestop=false

func stop_cassette():
	playing=false
	play_progress=0
	follow.progress=0
	lockout=false
	cassette_path.position=Vector2(0,0)
	var offset=position-cassette_path.curve.get_point_position(0)
	cassette_path.position+=offset
	Default.timestop=false

func _draw():
	draw_line(position-global_position,get_local_mouse_position(),Color.RED,-2.0)

func shoot():
	var new_bullet=bullet.instantiate()
	add_child(new_bullet)
	new_bullet.top_level=true
	new_bullet.position=position
	new_bullet.add_to_group("player_bullet")
	var angle=get_angle_to(get_global_mouse_position())
	new_bullet.direction=Vector2(cos(angle), sin(angle))

	

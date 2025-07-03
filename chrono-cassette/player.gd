extends CharacterBody2D
@onready var cassette_path=get_tree().get_first_node_in_group("path")
@onready var record_timer=get_node("record_timer")
@onready var follow=cassette_path.get_node("path")
@onready var cooldown=$shoot_cooldown

const speed = 150.0
var recording=false
var cassette_length=2
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
var can_shoot=true
@onready var spr=$sprite


var health=float(10)
var max_health=float(10)
var ammmo=5
var max_ammmo=5

@onready var reload_timer=$reload
@onready var empty=$gun/ColorRect

var i=false
@onready var i_timer=$i_timer

var can_record=true
@onready var record_cooldown=$record_cooldown

func over():
	queue_free() #deletes the player when game is over


func _physics_process(delta: float) -> void:
	mouse_pos=get_global_mouse_position()
	var direction=Input.get_vector("left","right","up","down")
	direction=direction.normalized()
	velocity=direction * speed
	var old_pos=position
	if velocity.x<0:
		spr.flip_h=true
	elif velocity.x>0:
		spr.flip_h=false
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
	if Input.is_action_just_pressed("play_cassette") and recording==false and can_record==true:
		play_cassette()
		can_record=false
		record_cooldown.start(10)
		record_cooldown.one_shot=true
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
	if cooldown.is_stopped()==true:
		can_shoot=true
	if record_cooldown.is_stopped()==true:
		can_record=true
	debug.text=str(can_record)
	
	queue_redraw()
	gun.rotation=get_angle_to(get_global_mouse_position())+(3.141592/2)
	if gun.rotation<0 or gun.rotation>3.141592:
		gun.flip_h=true
	else:
		gun.flip_h=false
	reload()
	if i_timer.is_stopped()==true:
		i=false

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
	#draw_line(position-global_position,get_local_mouse_position(),Color.RED,-2.0)
	var l=cassette_path.line
	l.default_color = Color.AQUA
	if playing==true:
		l.default_color = Color.RED
	l.width = 2
	l.clear_points()
	for point in cassette_path.curve.get_baked_points():  
		l.add_point(point)
	
func shoot():
	if can_shoot==true and ammmo>0:
		ammmo-=1
		if ammmo<0:
			ammmo=0
		var new_bullet=bullet.instantiate()
		add_child(new_bullet)
		new_bullet.top_level=true
		new_bullet.position=position
		new_bullet.add_to_group("player_bullet")
		var angle=get_angle_to(get_global_mouse_position())
		new_bullet.direction=Vector2(cos(angle), sin(angle))
		new_bullet.spr.rotation=angle+(3.141592/2)
		cooldown.start(0.25)
		cooldown.one_shot=true
		can_shoot=false

func reload():
	if ammmo<=0:
		empty.visible=true
	else:
		empty.visible=false
	if Input.is_action_just_pressed("reload"):
		reload_timer.start(2)
		reload_timer.one_shot=true
	if reload_timer.is_stopped()==true:
		ammmo=max_ammmo
		reload_timer.start(10000000000000)
	



func _on_hitbox_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.is_in_group("enemies"):
		if i==false:
			health-=3
			i_timer.start(0.25)
			i_timer.one_shot=true
			i=true

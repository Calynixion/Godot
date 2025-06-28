extends CharacterBody2D
@onready var path=$"../Path2D"
@onready var debug=$"../debug"
const speed=150
func _physics_process(delta: float) -> void:
	var direction=Input.get_vector("left","right","up","down")
	direction=direction.normalized()
	velocity=direction * speed
	move_and_slide()
	
	var p1=path.curve.get_point_position(1)
	debug.text=str(p1)+str(position)
	for i in 4:
		
		var point=path.curve.get_point_position(1)
		point+=(direction*speed)
		path.curve.remove_point(i)
		path.curve.add_point(point,Vector2(0,0),Vector2(0,0),i)
			
	#var i=0
	#var offset=path.curve.get_point_position(1)-path.curve.get_point_position(0)
	#var point=path.curve.get_point_position(i)
	#var new_point=(position-point)+point
	#path.curve.remove_point(i)
	#path.curve.add_point(new_point,Vector2(0,0),Vector2(0,0),i)
	#i=1
	#point=path.curve.get_point_position(i)
	#new_point=(position-point)+point+offset
	#path.curve.remove_point(i)
	#path.curve.add_point(new_point,Vector2(0,0),Vector2(0,0),i)
	#var len=4
	#for i in len-1:
		#var point=path.curve.get_point_position(2*i)
		#var offset=Vector2(0,0)
		#if i!=0:
			#offset=path.curve.get_point_position(2*i)-path.curve.get_point_position((2*i)-1)
		#var new_point=(position-point)+point+offset
		#path.curve.add_point(new_point,Vector2(0,0),Vector2(0,0),i)
	#for i in len-1:
		#path.curve.remove_point(len)
	#debug.text=str(path.curve.get_baked_points())
		#

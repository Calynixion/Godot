extends Node
@onready var sniper_timer=get_node("sniper_timer")
@onready var debug=get_node("debug")
@onready var sniper = get_tree().get_nodes_in_group("sniper")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sniper_timer.start(5)
	sniper_timer.one_shot=true
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	debug.text=str(sniper_timer.time_left)
	if sniper_timer.is_stopped()==true:
		debug.text="Done"
		sniper_timer.stop()
		if sniper != null:
			pass
		
	

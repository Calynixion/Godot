extends Control

@onready var player=get_tree().get_first_node_in_group("player")
@onready var hp_dyn=$hp_dyn
@onready var wheels=$cassette/wheels
@onready var ammmo_counter=$ammo_counter 
@onready var hp_text=$hp_text 
@onready var cassette_timer=$cassette_timer 
@onready var border=$border 
@onready var reloading=$reloading

func _process(delta: float) -> void:
	if player!=null and player.health>0:
		position=player.position+Vector2(-160,-120)
		if position.x<0:
			position.x=0
		if position.y<0:
			position.y=0
		if position.x>944:
			position.x=944
		if position.y>528:
			position.y=528
		ammmo_counter.text=str(player.ammmo)+"/"+str(player.max_ammmo)
		hp_text.text=str(int(player.health))+"/"+str(int(player.max_health))
		hp_dyn.size.x=128*(player.health/player.max_health)
		if player.recording==true:
			record()
		elif player.playing:
			play()
		else:
			normal()
		if player.reload_timer.time_left>0 and player.reload_timer.time_left<2:
			reloading.visible=true
		else:
			reloading.visible=false
func play():
	cassette_timer.text="Playing"
	border.border_color=Color.RED
	wheels.play("default")
func record():
	cassette_timer.text=str(player.record_timer.time_left)
	border.border_color=Color.AQUA
	wheels.play("reverse")
func normal():
	if player.record_cooldown.time_left!=0:
		cassette_timer.text=str(floor(player.record_cooldown.time_left))
	else:
		cassette_timer.text="Press Play"
	border.border_color=Color.GREEN
	wheels.stop()

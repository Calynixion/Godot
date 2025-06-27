extends Node2D

@onready var game_over_scrn = $GameOverScrn
@onready var player = get_tree().get_first_node_in_group("player")



func gameovernow():
	game_over_scrn.gameover()
	player.over()


func _on_game_over_scrn_restarted():
	get_tree().reload_current_scene()

extends Node2D

@onready var game_over_scrn = $GameOverScrn
@onready var player = get_tree().get_first_node_in_group("player")
@onready var gameover := false #tells if the game is currently over


func gameovernow():
	if gameover == false: # this is to make sure you cant have multiple gameovers since it will try to 
		gameover = true   #delete the player when it was already deleted
		game_over_scrn.gameover()
		player.over() #deletes player


func _on_game_over_scrn_restarted():
	gameover = false
	get_tree().reload_current_scene()

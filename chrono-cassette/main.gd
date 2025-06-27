extends Node2D

@onready var game_over_scrn = $GameOverScrn



func gameovernow():
	game_over_scrn.gameover()

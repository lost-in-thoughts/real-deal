extends Node2D

func _ready():
	if GameState.win != null:
		if GameState.win:
			if GameState.end():
				$"win_or_loose".text = "everyone is high! thank you for playing"
				$"click".text = "press space to play again"
			else:
				$"win_or_loose".text = "you won! lets go to the neighborhood"
				$"click".text = "press space to play next level"
		else:
			$"win_or_loose".text = "you lost! the officer has busted you"
			$"click".text = "press space to try again"

func _process(delta):
	pass

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_SPACE:
				get_tree().change_scene("res://level" + str(GameState.level) + ".tscn")

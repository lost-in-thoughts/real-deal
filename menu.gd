extends Node2D

func _ready():
	if GameState.win != null:
		if GameState.win:
			if GameState.end():
				$"win_or_loose".text = "everyone is high! thank you for playing"
				$"click".text = "click to play again"
			else:
				$"win_or_loose".text = "you won! lets go to the neighborhood"
				$"click".text = "click to play next level"
		else:
			$"win_or_loose".text = "you lost! the officer has busted you"
			$"click".text = "click to try again"

func _process(delta):
	pass

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.is_pressed():
				get_tree().change_scene("res://level" + str(GameState.level) + ".tscn")

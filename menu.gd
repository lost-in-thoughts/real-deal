extends Node2D

func _ready():
	if GameState.win != null:
		if GameState.win:
			if GameState.end():
				$"win_or_loose".text = "Everyone Is High! Thank You For Playing"
				$"click".text = "Press Space To Play Again"
			else:
				$"win_or_loose".text = "You won! Lets Go To The Neighborhood"
				$"click".text = "Press Space To Play Next Level"
		else:
			$"win_or_loose".text = "You Lost! The Officer Has Busted You"
			$"click".text = "Press Space To Try Again"

func _process(delta):
	if GameState.level != 0:
		$"tutorial".visible = false

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_SPACE:
				get_tree().change_scene("res://level" + str(GameState.level) + ".tscn")

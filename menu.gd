extends Node2D

func _ready():
	if GameState.win != null:
		if GameState.win:
			$"win_or_loose".text = "you won!"
		else:
			$"win_or_loose".text = "you lost! the officer has busted you"

func _process(delta):
	pass

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.is_pressed():
				get_tree().change_scene("res://game.tscn")

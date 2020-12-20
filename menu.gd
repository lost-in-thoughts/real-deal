extends Node2D

func _ready():
	pass

func _process(delta):
	pass
	

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.is_pressed():
				get_tree().change_scene("res://game.tscn")

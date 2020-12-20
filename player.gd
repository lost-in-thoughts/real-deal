extends KinematicBody2D

func _ready():
	pass

func _process(delta):
	var speed = 100
	
	var right = Input.is_action_pressed("ui_right")
	var left = Input.is_action_pressed("ui_left")
	var up = Input.is_action_pressed("ui_up")
	var down = Input.is_action_pressed("ui_down")
	var action = Input.is_action_pressed("ui_select")
	
	var horizontal = (-1 if left else 0) + (1 if right else 0)
	var vertical = (1 if down else 0) + (-1 if up else 0)
	var diagonal_scale = (1/sqrt(2)) if (horizontal != 0 && vertical != 0) else 1
	var dir = Vector2(horizontal, vertical) * diagonal_scale
	var vel = dir * speed
	
	move_and_slide(vel)

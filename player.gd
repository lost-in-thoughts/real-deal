extends KinematicBody2D

var in_business = false
var active_customer = null
var bags = 1

func _ready():
	$"..".add_player(self)

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
	
	if !in_business:
		move_and_slide(vel)
		
		if action:
			for customer in $"..".customers:
				if customer.ready_for_business:
					if $"area".overlaps_area(customer.get_node("area")):
						start_business(customer)
	
	win_condition()

func start_business(customer):
	print("start business")
	in_business = true
	$business_indicator.visible = true
	active_customer = customer
	active_customer.start_business()
	$Timer.start()

func stop_business():
	print("stop business")
	in_business = false
	active_customer.stop_business()
	active_customer = null
	$business_indicator.visible = false
	bags -= 1

func _on_Timer_timeout():
	stop_business()

func win_condition():
	if bags <= 0:
		$"..".win()

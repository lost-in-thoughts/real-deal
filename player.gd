extends KinematicBody2D

var in_business = false
var active_customer = null
var time_elapsed = 0
var time_since_start = 0

func _ready():
	$"../..".add_player(self)

func _process(delta):
	time_since_start += delta
	var speed = 100
	
	var right = Input.is_action_pressed("ui_right")
	var left = Input.is_action_pressed("ui_left")
	var up = Input.is_action_pressed("ui_up")
	var down = Input.is_action_pressed("ui_down")
	var action = Input.is_action_just_pressed("ui_select")
	
	var horizontal = (-1 if left else 0) + (1 if right else 0)
	var vertical = (1 if down else 0) + (-1 if up else 0)
	var diagonal_scale = (1/sqrt(2)) if (horizontal != 0 && vertical != 0) else 1
	var dir = Vector2(horizontal, vertical) * diagonal_scale
	var vel = dir * speed
	
	print(dir)
	# juice
	if !in_business and dir.length() > 0.5:
		time_elapsed += delta
		$Sprite.position.y = -8 * abs(sin(time_elapsed * 10))
		var x = sign(dir.x)
		if x != 0:
			$Sprite.scale.x = x
	else:
		time_elapsed = 0
		$Sprite.position.y = 0
	
	$player_selection.modulate.a = (sin(time_since_start * 5) + 1) / 2
	
	if !in_business:
		move_and_slide(vel)
		
		if action:
			for customer in $"../..".customers:
				if customer.ready_for_business && !customer.served:
					if $"area".overlaps_area(customer.get_node("area")):
						start_business(customer)
						break
	else:
		if action:
			cancel_business()

func start_business(customer):
	in_business = true
	$business_indicator.visible = true
	active_customer = customer
	active_customer.start_business()
	$Timer.start()

func stop_business():
	in_business = false
	active_customer.stop_business()
	active_customer = null
	$business_indicator.visible = false

func cancel_business():
	in_business = false
	active_customer.cancel_business()
	active_customer = null
	$business_indicator.visible = false
	$Timer.stop()

func _on_Timer_timeout():
	stop_business()

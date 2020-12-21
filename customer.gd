extends KinematicBody2D

var ready_for_business = false
var idle_time
var waiting_time
var time_elapsed = 0
var target = null
var target_reached = true
var served = false
var probability
var in_business = false
var speed
export(bool) var is_interested = true

func _ready():
	$"../..".add_customer(self)
	$Sprite.texture = load("res://customer/character0" + str(randi()%8+1)  + ".png")
	idle_time = 1 + randf() * 2
	waiting_time = 5 + randf() * 8
	probability = (0.1 + randf() * 0.4) * int(is_interested)
	speed = 50 + randf() * 50

func _process(delta):
	time_elapsed += delta
	
	$customer_selection.modulate.a *= 0.92
	
	# juice
	if !target_reached:
		$Sprite.position.y = -8 * abs(sin(time_elapsed * 10))
	if target:
		$Sprite.scale.x = sign(target.x - position.x)
	else:
		$Sprite.position.y = 0
	
	# move to a random position
	if !target_reached:
		if target == null:
			target = Vector2(randf() * 1024, 80 + randf() * 432)
		move_and_slide((target - position).normalized() * speed)
		if target.distance_to(position) < 10:
			target_reached = true
			time_elapsed = 0

	# wait random before the business starts
	elif time_elapsed > idle_time and !ready_for_business:
		if should_wait():
			start_ready_for_business()
			time_elapsed = 0
		else:
			target = null
			target_reached = false
			time_elapsed = 0

	# wait for the business to start
	elif time_elapsed > waiting_time and ready_for_business and !in_business:
		cancel_business()
		time_elapsed = 0
		target = null
		target_reached = false
		
	$"Sprite/rubin_eyes".visible = served
		
func should_wait():
	var extra = 1 - 1 / (1 + time_elapsed * 0.1)
	var prob = probability + extra * int(is_interested)
	return randf() < prob

func start_ready_for_business():
	ready_for_business = true
	if !served:
		$"ready_for_business_indicator".visible = true

func stop_ready_for_business():
	ready_for_business = false
	$"ready_for_business_indicator".visible = false

func start_business():
	in_business = true
	$"ready_for_business_indicator".visible = false

func stop_business():
	served = true
	in_business = false
	stop_ready_for_business()

func cancel_business():
	in_business = false
	stop_ready_for_business()

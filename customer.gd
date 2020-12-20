extends KinematicBody2D

var ready_for_business = false
var idle_time
var waiting_time
var time_elapsed = 0
var target = null
var target_reached
var served = false
var probability

func _ready():
	$"..".add_customer(self)
	$Sprite.texture = load("res://customer/character0" + str(randi()%8+1)  + ".png")
	print("texture set")
	idle_time = 1 + randf() * 2
	waiting_time = 5 + randf() * 8
	probability = 0.1 + randf() * 0.2

func _process(delta):
	time_elapsed += delta
	
	# move to a random position
	if !target_reached:
		if target == null:
			target = Vector2(randf() * 1024, 80 + randf() * 432)
		move_and_slide((target - position).normalized() * 100)
		if target.distance_to(position) < 10:
			target_reached = true
			time_elapsed = 0

	# wait random before the business starts
	elif time_elapsed > idle_time and !ready_for_business:
		if randf() < probability:
			start_ready_for_business()
			time_elapsed = 0
		else:
			target = null
			target_reached = false
			time_elapsed = 0

	# wait for the business to start
	elif time_elapsed > waiting_time and ready_for_business:
		cancel_business()
		time_elapsed = 0
		target = null
		target_reached = false
		
func should_wait():
	return randf() < probability

func start_ready_for_business():
	ready_for_business = true
	if !served:
		$"ready_for_business_indicator".visible = true

func stop_ready_for_business():
	ready_for_business = false
	$"ready_for_business_indicator".visible = false

func start_business():
	$"ready_for_business_indicator".visible = false

func stop_business():
	served = true
	stop_ready_for_business()

func cancel_business():
	stop_ready_for_business()

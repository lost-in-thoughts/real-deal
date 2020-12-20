extends Node2D

const probability = 0.01
var ready_for_business = false

func _ready():
	$"..".add_customer(self)

func _process(delta):
	if !ready_for_business && should_wait():
		start_ready_for_business()

func should_wait():
	return randf() < probability

func start_ready_for_business():
	ready_for_business = true
	$"ready_for_business_indicator".visible = true

func start_business():
	$"ready_for_business_indicator".visible = false

func stop_business():
	ready_for_business = false

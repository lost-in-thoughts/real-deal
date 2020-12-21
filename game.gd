extends Node2D

var customers = []
var officers = []
var player = null
var timer

func _ready():
	timer = Timer.new()
	timer.wait_time = 2
	timer.one_shot = true
	add_child(timer)
	timer.connect("timeout", self, "run_win")
	randomize()
	pass

func _process(delta):
	win_condition()

func add_customer(customer):
	customers.push_back(customer)

func add_officer(officer):
	officers.push_back(officer)

func add_player(p):
	player = p

func loose():
	GameState.win = false
	get_tree().change_scene("res://menu.tscn")

func win():
	GameState.win = true
	if timer.is_stopped():
		timer.start()

func run_win():
	GameState.increase_level()
	get_tree().change_scene("res://menu.tscn")

func win_condition():
	var count = 0
	for customer in customers:
		if !customer.served && customer.is_interested:
			count += 1
	
	$"hud/Label".text = str(count)
	
	if count == 0:
		win()

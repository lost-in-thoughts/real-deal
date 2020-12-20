extends Node2D

var customers = []
var officers = []
var player = null

func _ready():
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
	GameState.increase_level()
	get_tree().change_scene("res://menu.tscn")

func win_condition():
	for customer in customers:
		if !customer.served:
			return
	win()

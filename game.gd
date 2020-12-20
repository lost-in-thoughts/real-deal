extends Node2D

var customers = []
var officers = []
var player = null

func _ready():
	pass

func _process(delta):
	pass

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
	get_tree().change_scene("res://menu.tscn")

extends Node2D

var customers = []
var officers = []
var player = null

func _ready():
	randomize()
	pass

func _process(delta):
	pass

func add_customer(customer):
	customers.push_back(customer)

func add_officer(officer):
	officers.push_back(officer)

func add_player(p):
	player = p

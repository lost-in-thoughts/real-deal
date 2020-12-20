extends KinematicBody2D

var chaising = false

func _ready():
	$"..".add_officer(self)
	
func _process(delta):
	var player = $"..".player
	if player:
		if $"area".overlaps_area(player.get_node("area")):
			if !chaising and player.in_business:
				start_chaising()
		elif chaising:
			stop_chaising()
	
	if chaising:
		chaise()
	else:
		idle()

func chaise():
	var player = $"..".player
	if $"bust_area".overlaps_area(player.get_node("area")):
		$"..".loose()
	
	var speed = 50
	var dir = (player.position - position).normalized()
	var vel = dir * speed
	move_and_slide(vel)

func idle():
	pass

func start_chaising():
	print("start chaising")
	chaising = true

func stop_chaising():
	print("stop chaising")
	chaising = false

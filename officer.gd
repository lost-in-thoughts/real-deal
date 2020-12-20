extends KinematicBody2D

var chaising = false

func _ready():
	$"..".add_officer(self)
	
func _process(delta):
	var player = $"..".player
	if player:
		if $"area".overlaps_area(player.get_node("area")):
			if !chaising && player.in_business:
				start_chaising()
		elif chaising:
			stop_chaising()
	
	if chaising:
		chaise()
	else:
		idle()

func chaise():
	var player = $"..".player
	var dir = (player.position - position).normalized()
	move_and_slide(dir)

func idle():
	pass

func start_chaising():
	print("start chaising")
	chaising = true

func stop_chaising():
	print("stop chaising")
	chaising = false

extends KinematicBody2D

var chaising = false
var target = null
var time_elapsed = 0

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
		
	# juice
	if target:
		time_elapsed += delta
		$Sprite.position.y = -8 * abs(sin(time_elapsed * 10))
		var x = sign(target.x - position.x)
		if x != 0:
			$Sprite.scale.x = x
	else:
		time_elapsed = 0
		$Sprite.position.y = 0

func chaise():
	var player = $"..".player
	if $"bust_area".overlaps_area(player.get_node("area")):
		$"..".loose()
	
	var speed = 50
	var dir = (player.position - position).normalized()
	var vel = dir * speed
	move_and_slide(vel)

func idle():
	if target == null:
		target = Vector2(randf() * 1024, 80 + randf() * 432)
	move_and_slide((target - position).normalized() * 60)
	if target.distance_to(position) < 10:
		target = null

func start_chaising():
	print("start chaising")
	$chase_indicator.visible = true
	chaising = true

func stop_chaising():
	print("stop chaising")
	$chase_indicator.visible = false
	chaising = false

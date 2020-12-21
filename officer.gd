extends KinematicBody2D

var chaising = false
var target = null
var time_elapsed = 0
var time_elapsed_chaise = 0
var max_chaise_time = 5
var time_since_start = 0

func _ready():
	$"../..".add_officer(self)
	
func _process(delta):
	time_since_start += delta
	var player = $"../..".player
	if player:
		if $"area".overlaps_area(player.get_node("area")) and time_elapsed_chaise < max_chaise_time:
			if !chaising and player.in_business:
				start_chaising()
		elif chaising:
			stop_chaising()
	
	if chaising:
		chaise()
		time_elapsed_chaise += delta
	else:
		idle()
		time_elapsed_chaise = 0
		
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
	
	if chaising:
		if sin(time_since_start * 3) > 0:
			$"../../hud/ColorRect".color = Color(1, 0, 0, 0.15)
		else:
			$"../../hud/ColorRect".color = Color(0, 0, 1, 0.15)
	else:
		$"../../hud/ColorRect".color = Color(0, 0, 0, 0.0)

func chaise():
	var player = $"../..".player
	if $"bust_area".overlaps_area(player.get_node("area")):
		$"../..".loose()
	
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
	$chase_indicator.visible = true
	chaising = true

func stop_chaising():
	$chase_indicator.visible = false
	chaising = false

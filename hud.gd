extends Node2D

var time_since_start = 0
var sirene = 0

func _process(delta: float) -> void:
	time_since_start += delta

	if sirene <= 0:
		$"ColorRect".color = Color(0, 0, 0, 0)
		return
	
	if sin(time_since_start * 3) > 0:
		$"ColorRect".color = Color(1, 0, 0, 0.15)
	else:
		$"ColorRect".color = Color(0, 0, 1, 0.15)

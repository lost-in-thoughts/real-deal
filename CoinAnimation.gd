extends Sprite

func spawn(pos):
	$Tween.interpolate_property(self, "position",
		pos, Vector2(970, 60), 1.5,
		Tween.TRANS_QUAD, Tween.EASE_IN)
		
	$Tween.interpolate_property(self, "scale",
		Vector2(0.2, 0.2), Vector2(1.5, 1.5), 1.5,
		Tween.TRANS_QUAD, Tween.EASE_IN)
		
	$Tween.interpolate_property(self, "modulate",
		Color(1, 1, 1, .5), Color(1, 1, 1, 1), 1.5,
		Tween.TRANS_QUAD, Tween.EASE_IN)
	$Tween.start()
	

func _on_Tween_tween_all_completed() -> void:
	queue_free()

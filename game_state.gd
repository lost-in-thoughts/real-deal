extends Node2D

var win = null
var level = 1
var levels_count = 3

func increase_level():
	level = (level + 1) % levels_count

func end():
	return level == 0

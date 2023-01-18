extends Node

static func rotate_vector(vector, angle, change := false):
	var xp = (vector.x * cos(-angle)) - (vector.y * sin(-angle))
	var yp = (vector.x * sin(-angle)) + (vector.y * cos(-angle))
	var output = Vector2(xp, yp) - vector if change else Vector2(xp, yp)
	return output

var obj_pos : Vector2
var player_pos : Vector2

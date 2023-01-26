extends Node

static func rotate_vector(vector, angle, change := false):
	var xp = (vector.x * cos(-angle)) - (vector.y * sin(-angle))
	var yp = (vector.x * sin(-angle)) + (vector.y * cos(-angle))
	var output = Vector2(xp, yp) - vector if change else Vector2(xp, yp)
	return output

static func flatten_vector(input, target):
	var a = atan2(target.x, target.y)
	var b = atan2(input.x, input.y) - a
	var h = sqrt(input.x**2 + input.y**2)
	return input + Vector2(h*sin(b)*-cos(a), h*sin(b)*sin(a))

var obj_pos : Vector2
var player_pos : Vector2

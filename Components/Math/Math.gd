extends Node

const VEC_UP = Vector2(0, 1)
const VEC_DOWN = Vector2(0, -1)
const VEC_LEFT = Vector2(-1, 0)
const VEC_RIGHT = Vector2(1, 0)

const RAD_UP = 0.5*PI
const RAD_DOWN = 1.5*PI
const RAD_LEFT = PI
const RAD_RIGHT = 0

static func get_perp(input:Vector2):
	return Vector2(input.y, -input.x)

static func rad_to_vec(input:float):
	return Vector2(cos(input), sin(input))

static func vec_to_rad(input:Vector2):
	return atan2(input.y, input.x)

static func hyp(input):
	return sqrt(input.x**2 + input.y**2)

static func project_vector(input:Vector2, target:Vector2): #input = u, target = v
	return (input.dot(target) / (target.x**2 + target.y**2)) * target

static func rotate_vector(input, angle, change := false):
	var xp = (input.x * cos(-angle)) - (input.y * sin(-angle))
	var yp = (input.x * sin(-angle)) + (input.y * cos(-angle))
	var output = Vector2(xp, yp) - input if change else Vector2(xp, yp)
	return output

var obj_pos : Vector2
var player_pos : Vector2

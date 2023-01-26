extends RayCast2D

@export_category("DistanceRaycast")
@export var distance_offset = 0.0

# Distance Functions
func get_distance():
	force_raycast_update()
	var output = \
		get_collision_point() - ((to_global(target_position) - global_position).normalized() * distance_offset) - global_position if is_colliding() and enabled \
		else Vector2(0, 0)#(to_global(target_position) - global_position) - ((to_global(target_position) - global_position).normalized() * distance_offset)
	return output
func get_relative_distance(angle):
	var x = get_distance().x
	var y = get_distance().y
	var xp = (x * cos(-angle)) - (y * sin(-angle))
	var yp = (x * sin(-angle)) + (y * cos(-angle))
	return yp
	#return sqrt(pow(get_distance().x, 2) + pow(get_distance().y, 2))

# Normal Functions
func get_normal():
	force_raycast_update()
	var output = get_collision_normal() if is_colliding() and enabled else Vector2(0, 0)
	return output
func get_relative_normal(angle):
	var x = get_normal().x
	var y = get_normal().y
	var xp = (x * cos(-angle)) - (y * sin(-angle))
	var yp = (x * sin(-angle)) + (y * cos(-angle))
	return Vector2(xp, yp)
func get_normal_zero():
	return Math.rotate_vector(Vector2(cos(global_rotation), sin(global_rotation)), atan2(target_position.x, target_position.y))

func get_slope():
	return Math.rotate_vector(get_normal(), 1.5*PI)

# Angle Functions (measured in radians)
func get_angle():
	var output = \
		wrapf(atan2(get_collision_normal().x, get_collision_normal().y)-PI, 0, 2*PI) if is_colliding() and enabled \
		else 0
	return output
func get_relative_angle(angle):
	var output = \
		wrapf(-atan2(get_collision_normal().x, get_collision_normal().y)-PI - angle, 0, 2*PI) if is_colliding() and enabled \
		else wrapf(angle, 0, 2*PI)
	return output

func is_colliding():
	force_raycast_update()
	return is_colliding()

#func _process(delta):
#	print(get_distance())
#	print(get_relative_distance())
#	print(get_normal())
#	print(get_relative_normal(rotation))
#	print(get_angle())
#	print(get_relative_angle(rotation))

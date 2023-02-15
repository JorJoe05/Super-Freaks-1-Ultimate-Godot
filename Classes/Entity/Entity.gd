extends Node2D
class_name Entity

@export var velocity : Vector2
@export var angular_velocity : float
@export var gravity = 0.2

@export_group("Colliders")
@export_subgroup("Hitbox Collision")
@export var hitbox_node : Node
@export_subgroup("Solid Collision")
@export var collider_node : Node

func set_velocity(input:Vector2, target, exclude:int = 0): #0 = none, 1 = y, 2 = x, 3 = both
	var ang = target if target is float else Math.vec_to_rad(target)
	var vec = target if target is Vector2 else Math.rad_to_vec(target)
	velocity = \
		Math.rotate_vector(input, ang) if exclude == 0 \
		else Math.project_vector(velocity, Math.get_perp(vec)) + Math.rotate_vector(Vector2(input.x, 0), -ang) if exclude == 1 \
		else Math.project_vector(velocity, vec) + Math.rotate_vector(Vector2(0, input.y), -ang) if exclude == 2 \
		else velocity

func add_velocity(input:Vector2, target):
	var ang = target if target is float else Math.vec_to_rad(target)
	velocity += Math.rotate_vector(input, -ang)

func get_velocity(target):
	var ang = target if target is float else Math.vec_to_rad(target)
	return Math.rotate_vector(velocity, ang)

# Collision Functions
# No Snap
func push_top():
	if collider_node.get_active_sensor_top().get_relative_distance(collider_node.global_rotation+PI) < 0 and collider_node.get_active_sensor_top().is_colliding():
		position += collider_node.get_active_sensor_top().get_distance()
		velocity = Math.project_vector(velocity, collider_node.get_active_sensor_top().get_normal_zero())
func push_bottom():
	if collider_node.get_active_sensor_bottom().get_relative_distance(collider_node.global_rotation) < 0 and collider_node.get_active_sensor_bottom().is_colliding():
		position += collider_node.get_active_sensor_bottom().get_distance()
		velocity = Math.project_vector(velocity, collider_node.get_active_sensor_bottom().get_normal_zero())
func push_left():
	if collider_node.get_active_sensor_left().get_relative_distance(collider_node.global_rotation+(0.5*PI)) < 0 and collider_node.get_active_sensor_left().is_colliding():
		position += collider_node.get_active_sensor_left().get_distance()
		velocity = Math.project_vector(velocity, collider_node.get_active_sensor_left().get_normal_zero())
func push_right():
	if collider_node.get_active_sensor_right().get_relative_distance(collider_node.global_rotation+(1.5*PI)) < 0 and collider_node.get_active_sensor_right().is_colliding():
		position += collider_node.get_active_sensor_right().get_distance()
		velocity = Math.project_vector(velocity, collider_node.get_active_sensor_right().get_normal_zero())
# With Snap
func snap_top():
	if collider_node.get_active_sensor_top().is_colliding():
		position += collider_node.get_active_sensor_top().get_distance()
		velocity = Vector2(0, 0)
func snap_bottom():
	if collider_node.get_active_sensor_bottom().is_colliding():
		position += collider_node.get_active_sensor_bottom().get_distance()
		velocity = Vector2(0, 0)
func snap_left():
	if collider_node.get_active_sensor_left().is_colliding():
		position += collider_node.get_active_sensor_left().get_distance()
		velocity = Vector2(0, 0)
func snap_right():
	if collider_node.get_active_sensor_right().is_colliding():
		position += collider_node.get_active_sensor_right().get_distance()
		velocity = Vector2(0, 0)

func collide():
	collider_node.extra_range = max(16, abs(velocity.x), abs(velocity.y))
	collider_node.collider_update()
	push_top()
	push_bottom()
	push_left()
	push_right()
func collide_with_snap():
	collider_node.extra_range = max(16, abs(velocity.x), abs(velocity.y))
	collider_node.collider_update()
	push_top()
	snap_bottom()
	push_left()
	push_right()

func apply_gravity():
	velocity += gravity * Vector2(-sin(rotation), cos(rotation))

func apply_velocity():
	position += velocity

func apply_angular_velocity():
	rotation += angular_velocity

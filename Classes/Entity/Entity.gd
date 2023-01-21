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

# Collision Functions
# No Snap
func push_top():
	if collider_node.get_active_sensor_top().get_relative_distance(collider_node.global_rotation+PI) < 0 and collider_node.get_active_sensor_top().is_colliding():
		position += collider_node.get_active_sensor_top().get_distance()
		velocity = Vector2(0, 0)
func push_bottom():
	if collider_node.get_active_sensor_bottom().get_relative_distance(collider_node.global_rotation) < 0 and collider_node.get_active_sensor_bottom().is_colliding():
		position += collider_node.get_active_sensor_bottom().get_distance()
		velocity = Vector2(0, 0)
func push_left():
	if collider_node.get_active_sensor_left().get_relative_distance(collider_node.global_rotation+(0.5*PI)) < 0 and collider_node.get_active_sensor_left().is_colliding():
		position += collider_node.get_active_sensor_left().get_distance()
		velocity = Vector2(0, 0)
func push_right():
	if collider_node.get_active_sensor_right().get_relative_distance(collider_node.global_rotation+(1.5*PI)) < 0 and collider_node.get_active_sensor_right().is_colliding():
		position += collider_node.get_active_sensor_right().get_distance()
		velocity = Vector2(0, 0)
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
	push_top()
	push_bottom()
	push_left()
	push_right()
func collide_with_snap():
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

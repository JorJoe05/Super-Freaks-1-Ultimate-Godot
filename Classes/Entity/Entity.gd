extends Node2D
class_name Entity

var velocity : Vector2

@export_group("Colliders")
@export_subgroup("Hitbox Collision")
@export var hitbox_node : Node
@export var hitbox_diameter = Vector2(16, 32)
@export_subgroup("Solid Collision")
@export var collider_node : Node
@export var collider_offset = Vector2(0, 4)
@export var collider_radius = Vector2(14, 20)
@export var top_ext_radius = 6.0
@export var sides_ext_radius = 12.0
@export var bottom_ext_radius = 8.0
@export var extra_range = 16.0

func collider_update():
	collider_node.collider_offset = collider_offset
	collider_node.collider_radius = collider_radius
	collider_node.top_ext_radius = top_ext_radius
	collider_node.sides_ext_radius = sides_ext_radius
	collider_node.bottom_ext_radius = bottom_ext_radius
	collider_node.extra_range = extra_range
	collider_node.collider_update()

func pop_out_top():
	if collider_node.get_active_sensor_top().get_relative_distance(collider_node.global_rotation+PI) < 0:
		position += collider_node.get_active_sensor_top().get_distance()
		#velocity = Vector2(0, 0)
		velocity.y = 0
func pop_out_bottom():
	if collider_node.get_active_sensor_bottom().get_relative_distance(collider_node.global_rotation) < 0:
		position += collider_node.get_active_sensor_bottom().get_distance()
		#position.y += collider_node.get_active_sensor_bottom().get_distance().y
		#velocity = Vector2(0, 0)
		velocity.y = 0
func pop_out_left():
	if collider_node.get_active_sensor_left().get_relative_distance(collider_node.global_rotation+(0.5*PI)) < 0:
		position += collider_node.get_active_sensor_left().get_distance()
		#velocity = Vector2(0, 0)
		velocity.x = 0
func pop_out_right():
	if collider_node.get_active_sensor_right().get_relative_distance(collider_node.global_rotation+(1.5*PI)) < 0:
		position += collider_node.get_active_sensor_right().get_distance()
		#velocity = Vector2(0, 0)
		velocity.x = 0

# Collision Functions
func push_top():
	if collider_node.dist_top() > 0:
		position.y += collider_node.dist_top()
		velocity.y = 0
func push_bottom():
	if collider_node.dist_bottom() < 0:
		position.y += collider_node.dist_bottom()
		velocity.y = 0
func push_left():
	if collider_node.dist_left() > 0:
		position.x += collider_node.dist_left()
		velocity.x = 0
func push_right():
	if collider_node.dist_right() < 0:
		position.x += collider_node.dist_right()
		velocity.x = 0

func collide():
	pop_out_top()
	pop_out_bottom()
	pop_out_left()
	pop_out_right()
	#push_top()
	#push_bottom()
	#push_left()
	#push_right()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

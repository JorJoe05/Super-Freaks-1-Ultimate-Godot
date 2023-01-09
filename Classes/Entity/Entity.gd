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
	push_top()
	push_bottom()
	push_left()
	push_right()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

@tool
extends Node2D

# Collider Variables
@export var collider_offset = Vector2(0, 4)
@export var collider_radius = Vector2(14, 20)
@export var top_ext_radius = 6.0
@export var sides_ext_radius = 12.0
@export var bottom_ext_radius = 8.0
# Collider Nodes
@onready var ColliderRoot = get_node("ColliderRoot")
@onready var TopExtA = get_node("%TopExtA")
@onready var TopCenter = get_node("%TopCenter")
@onready var TopExtB = get_node("%TopExtB")
@onready var BottomExtA = get_node("%BottomExtA")
@onready var BottomCenter = get_node("%BottomCenter")
@onready var BottomExtB = get_node("%BottomExtB")
@onready var LeftExtA = get_node("%LeftExtA")
@onready var LeftCenter = get_node("%LeftCenter")
@onready var LeftExtB = get_node("%LeftExtB")
@onready var RightExtA = get_node("%RightExtA")
@onready var RightCenter = get_node("%RightCenter")
@onready var RightExtB = get_node("%RightExtB")

# Editor Hint Nodes
@onready var EHRoot = get_node("EditorHint")
@onready var EHTop = get_node("EditorHint/Top")
@onready var EHBottom = get_node("EditorHint/Bottom")
@onready var EHLeft = get_node("EditorHint/Left")
@onready var EHRight = get_node("EditorHint/Right")
@onready var EHRectRoot = get_node("EditorHint/RectRoot")
@onready var EHRect = get_node("EditorHint/RectRoot/Rect")

# Collider functions
# Updaters
func collider_init():
	if !Engine.is_editor_hint():
		ColliderRoot.visible = 1
	ColliderRoot.position = collider_offset
	collider_update_top()
	collider_update_bottom()
	collider_update_left()
	collider_update_right()
func collider_update_top():
	TopExtA.position.x = -top_ext_radius
	TopExtB.position.x = top_ext_radius
	TopExtA.target_position.y = -collider_radius.y - 16
	TopCenter.target_position.y = -collider_radius.y - 16
	TopExtB.target_position.y = -collider_radius.y - 16
func collider_update_bottom():
	BottomExtA.position.x = -bottom_ext_radius
	BottomExtB.position.x = bottom_ext_radius
	BottomExtA.target_position.y = collider_radius.y + 16
	BottomCenter.target_position.y = collider_radius.y + 16
	BottomExtB.target_position.y = collider_radius.y + 16
func collider_update_left():
	LeftExtA.position.y = -sides_ext_radius
	LeftExtB.position.y = sides_ext_radius
	LeftExtA.target_position.x = -collider_radius.x - 16
	LeftCenter.target_position.x = -collider_radius.x - 16
	LeftExtB.target_position.x = -collider_radius.x - 16
func collider_update_right():
	RightExtA.position.y = -sides_ext_radius
	RightExtB.position.y = sides_ext_radius
	RightExtA.target_position.x = collider_radius.x + 16
	RightCenter.target_position.x = collider_radius.x + 16
	RightExtB.target_position.x = collider_radius.x + 16
# Colliders
func get_dist(collider_node):
	return collider_node.get_collision_point() - collider_node.global_position
func get_rad(collider_node):
	return atan2(collider_node.get_collision_normal().x, collider_node.get_collision_normal().y)
func dist_top():
	collider_update_top()
	var exta = get_dist(TopExtA).y + collider_radius.y if TopExtA.is_colliding() and get_rad(TopExtA) == 0 else 0
	var extb = get_dist(TopExtB).y + collider_radius.y if TopExtB.is_colliding() and get_rad(TopExtB) == 0 else 0
	var output = max(exta, extb)
	output = get_dist(TopCenter).y + collider_radius.y if TopCenter.is_colliding() else output
	return output
func dist_bottom():
	collider_update_bottom()
	var exta = get_dist(BottomExtA).y - collider_radius.y if BottomExtA.is_colliding() and get_rad(BottomExtA) == PI else 16
	var extb = get_dist(BottomExtB).y - collider_radius.y if BottomExtB.is_colliding() and get_rad(BottomExtB) == PI else 16
	var output = min(exta, extb)
	output = get_dist(BottomCenter).y - collider_radius.y if BottomCenter.is_colliding() else output
	return output
func dist_left():
	collider_update_left()
	var exta = get_dist(LeftExtA).x + collider_radius.x if LeftExtA.is_colliding() and get_rad(LeftExtA) == (PI/2) else 0
	var extb = get_dist(LeftExtB).x + collider_radius.x if LeftExtB.is_colliding() and get_rad(LeftExtB) == (PI/2) else 0
	var output = max(exta, extb)
	output = get_dist(LeftCenter).x + collider_radius.x if LeftCenter.is_colliding() else output
	return output
func dist_right():
	collider_update_right()
	var exta = get_dist(RightExtA).x - collider_radius.x if RightExtA.is_colliding() and get_rad(RightExtA) == -(PI/2) else 0
	var extb = get_dist(RightExtB).x - collider_radius.x if RightExtB.is_colliding() and get_rad(RightExtB) == -(PI/2) else 0
	var output = min(exta, extb)
	output = get_dist(RightCenter).x - collider_radius.x if RightCenter.is_colliding() else output
	return output

func _ready():
	collider_init()

func _process(delta):
	if Engine.is_editor_hint():
		editor_hint_update()
	else:
		EHRoot.visible = 0

func editor_hint_update():
	EHRoot.visible = 1
	EHRoot.position = collider_offset
	EHTop.position.y = -collider_radius.y + 0.5
	EHTop.points = [Vector2(-top_ext_radius, 0), Vector2(top_ext_radius, 0)]
	EHBottom.position.y = collider_radius.y - 0.5
	EHBottom.points = [Vector2(-bottom_ext_radius, 0), Vector2(bottom_ext_radius, 0)]
	EHLeft.position.x = -collider_radius.x + 0.5
	EHLeft.points = [Vector2(0, -sides_ext_radius), Vector2(0, sides_ext_radius)]
	EHRight.position.x = collider_radius.x - 0.5
	EHRight.points = [Vector2(0, -sides_ext_radius), Vector2(0, sides_ext_radius)]
	EHRectRoot.position = -collider_radius
	EHRect.size = collider_radius * 2

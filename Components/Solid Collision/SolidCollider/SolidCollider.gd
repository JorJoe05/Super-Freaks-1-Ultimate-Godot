@tool
extends Node2D

# Collider Variables
@export var collider_offset = Vector2(0, 4)
@export var collider_radius = Vector2(14, 20)
@export var top_ext_radius = 6.0
@export var sides_ext_radius = 12.0
@export var bottom_ext_radius = 8.0
@export var extra_range = 16.0

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

func collider_update():
	ColliderRoot.position = collider_offset
	collider_update_top()
	collider_update_bottom()
	collider_update_left()
	collider_update_right()
func collider_update_top():
	TopExtA.position = Vector2(-top_ext_radius, 0)
	TopExtA.target_position = Vector2(0, -collider_radius.y-extra_range)
	TopExtA.distance_offset = collider_radius.y
	TopCenter.position = Vector2(0, 0)
	TopCenter.target_position = Vector2(0, -collider_radius.y-extra_range)
	TopCenter.distance_offset = collider_radius.y
	TopExtB.position = Vector2(top_ext_radius, 0)
	TopExtB.target_position = Vector2(0, -collider_radius.y-extra_range)
	TopExtB.distance_offset = collider_radius.y
func collider_update_bottom():
	BottomExtA.position = Vector2(-bottom_ext_radius, 0)
	BottomExtA.target_position = Vector2(0, collider_radius.y+extra_range)
	BottomExtA.distance_offset = collider_radius.y
	BottomCenter.position = Vector2(0, 0)
	BottomCenter.target_position = Vector2(0, collider_radius.y+extra_range)
	BottomCenter.distance_offset = collider_radius.y
	BottomExtB.position = Vector2(bottom_ext_radius, 0)
	BottomExtB.target_position = Vector2(0, collider_radius.y+extra_range)
	BottomExtB.distance_offset = collider_radius.y
func collider_update_left():
	LeftExtA.position = Vector2(0, -sides_ext_radius)
	LeftExtA.target_position = Vector2(-collider_radius.x-extra_range, 0)
	LeftExtA.distance_offset = collider_radius.x
	LeftCenter.position = Vector2(0, 0)
	LeftCenter.target_position = Vector2(-collider_radius.x-extra_range, 0)
	LeftCenter.distance_offset = collider_radius.x
	LeftExtB.position = Vector2(0, sides_ext_radius)
	LeftExtB.target_position = Vector2(-collider_radius.x-extra_range, 0)
	LeftExtB.distance_offset = collider_radius.x
func collider_update_right():
	RightExtA.position = Vector2(0, -sides_ext_radius)
	RightExtA.target_position = Vector2(collider_radius.x+extra_range, 0)
	RightExtA.distance_offset = collider_radius.x
	RightCenter.position = Vector2(0, 0)
	RightCenter.target_position = Vector2(collider_radius.x+extra_range, 0)
	RightCenter.distance_offset = collider_radius.x
	RightExtB.position = Vector2(0, sides_ext_radius)
	RightExtB.target_position = Vector2(collider_radius.x+extra_range, 0)
	RightExtB.distance_offset = collider_radius.x

func set_top_enabled(mode): #0: Disabled | 1: Enabled | 2: Middle Only
	TopExtA.enabled = true if mode == 1 else false
	TopCenter.enabled = false if mode == 0 else true
	TopExtB.enabled = true if mode == 1 else false
func set_bottom_enabled(mode):
	BottomExtA.enabled = true if mode == 1 else false
	BottomCenter.enabled = false if mode == 0 else true
	BottomExtB.enabled = true if mode == 1 else false
func set_left_enabled(mode):
	LeftExtA.enabled = true if mode == 1 else false
	LeftCenter.enabled = false if mode == 0 else true
	LeftExtB.enabled = true if mode == 1 else false
func set_right_enabled(mode):
	RightExtA.enabled = true if mode == 1 else false
	RightCenter.enabled = false if mode == 0 else true
	RightExtB.enabled = true if mode == 1 else false

func get_active_sensor_top():
	var output = TopCenter
	if TopExtA.get_relative_distance(global_rotation+PI) < TopExtB.get_relative_distance(global_rotation+PI) and round(rad_to_deg(TopExtA.get_relative_angle(global_rotation+PI))) == 0:
		output = TopExtA
	elif TopExtB.get_relative_distance(global_rotation+PI) < TopExtA.get_relative_distance(global_rotation) and round(rad_to_deg(TopExtB.get_relative_angle(global_rotation+PI))) == 0:
		output = TopExtB
	if TopCenter.is_colliding():
		output = TopCenter
	return output
func get_active_sensor_bottom():
	var output = BottomCenter
	if BottomExtA.get_relative_distance(global_rotation) < BottomExtB.get_relative_distance(global_rotation) and round(rad_to_deg(BottomExtA.get_relative_angle(global_rotation))) == 0:
		output = BottomExtA
	elif BottomExtB.get_relative_distance(global_rotation) < BottomExtA.get_relative_distance(global_rotation) and round(rad_to_deg(BottomExtB.get_relative_angle(global_rotation))) == 0:
		output = BottomExtB
	if BottomCenter.is_colliding():
		output = BottomCenter
	return output
func get_active_sensor_left():
	var output = LeftCenter
	if LeftExtA.get_relative_distance(global_rotation+(0.5*PI)) < LeftExtB.get_relative_distance(global_rotation+(0.5*PI)) and round(rad_to_deg(LeftExtA.get_relative_angle(global_rotation+(0.5*PI)))) == 0:
		output = LeftExtA
	elif LeftExtB.get_relative_distance(global_rotation+(0.5*PI)) < LeftExtA.get_relative_distance(global_rotation+(0.5*PI)) and round(rad_to_deg(LeftExtB.get_relative_angle(global_rotation+(0.5*PI)))) == 0:
		output = LeftExtB
	if LeftCenter.is_colliding():
		output = LeftCenter
	return output
func get_active_sensor_right():
	var output = RightCenter
	if RightExtA.get_relative_distance(global_rotation+(1.5*PI)) < RightExtB.get_relative_distance(global_rotation+(1.5*PI)) and round(rad_to_deg(RightExtA.get_relative_angle(global_rotation+(1.5*PI)))) == 0:
		output = RightExtA
	elif RightExtB.get_relative_distance(global_rotation+(1.5*PI)) < RightExtA.get_relative_distance(global_rotation+(1.5*PI)) and round(rad_to_deg(RightExtB.get_relative_angle(global_rotation+(1.5*PI)))) == 0:
		output = RightExtB
	if RightCenter.is_colliding():
		output = RightCenter
	return output

func _ready():
	collider_update()

func _process(delta):
	if Engine.is_editor_hint():
		editor_hint_update()
		collider_update()
	else:
		EHRoot.visible = 0
		#print(" ")
		#print(get_active_sensor_top())
		#print(get_active_sensor_bottom())
		#print(get_active_sensor_left())
		#print(get_active_sensor_right())

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

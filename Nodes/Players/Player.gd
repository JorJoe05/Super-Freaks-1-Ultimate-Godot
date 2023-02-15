extends Entity

@export var player_id : int
var player_spriteframes = [
	preload("res://Sprites/Player Characters/Scruffy/SpriteFrames_Scruffy.tres"),
	preload("res://Sprites/Player Characters/King Quincy/SpriteFrames_Quincy.tres"),
	preload("res://Sprites/Player Characters/Gambi/SpriteFrames_Gambi.tres"),
	preload("res://Sprites/Player Characters/Tikiman/SpriteFrames_Tikiman.tres")
]

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.frames = player_spriteframes[player_id]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	apply_gravity()
	#velocity.y += 0.2
	if Input.is_action_pressed("Left"):
		#velocity = Math.project_vector(velocity, Math.rad_to_vec(rotation+Math.RAD_UP)) - 3*Math.rad_to_vec(rotation)
		if get_velocity(rotation).x > -3:
			add_velocity(Vector2(-.3, 0), rotation)
		$AnimatedSprite2D.flip_h = 1
		$AnimatedSprite2D.animation = "walk"
	elif Input.is_action_pressed("Right"):
		#velocity = Math.project_vector(velocity, Math.rad_to_vec(rotation+Math.RAD_UP)) + 3*Math.rad_to_vec(rotation)
		if get_velocity(rotation).x < 3:
			add_velocity(Vector2(.3, 0), rotation)
		$AnimatedSprite2D.flip_h = 0
		$AnimatedSprite2D.animation = "walk"
	else:
		#velocity = Math.project_vector(velocity, Math.rad_to_vec(rotation+Math.RAD_UP))
		set_velocity(Vector2(0, 0), rotation, 0b01)
		$AnimatedSprite2D.animation = "stand"
	if Input.is_action_just_pressed("Jump - Confirm"):
		#velocity = -7*Vector2(-sin(rotation), cos(rotation))
		set_velocity(Vector2(0, -7), rotation, 0b10)
		#pass
	
	#velocity = Vector2(0, 0)
	#velocity.x = 1
	if Input.is_action_pressed("Debug"):
		velocity = Input.get_last_mouse_velocity()*0.005#Vector2(round(Input.get_joy_axis(0, JOY_AXIS_RIGHT_X)*4), round(Input.get_joy_axis(0, JOY_AXIS_RIGHT_Y)*4))*2
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	else:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		pass
	apply_velocity()
	#position.x += 3
	Math.player_pos = to_global(collider_node.get_active_sensor_bottom().get_distance())
	
	#if collider_node.get_active_sensor_bottom().is_colliding():
	#	rotation = -collider_node.get_active_sensor_bottom().get_angle()
	#rotation = atan2(-Math.obj_pos.x + Math.player_pos.x, Math.obj_pos.y - Math.player_pos.y)
	
	#position += Math.rotate_vector(Math.obj_pos - Math.player_pos, 0.05, true)
	if !Input.is_action_pressed("Debug"):
		collide()

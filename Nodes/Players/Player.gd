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
	if Input.is_action_pressed("ui_left"):
		position -= 3*Math.rotate_vector(Vector2(1, 0), collider_node.get_active_sensor_bottom().get_angle())
		$AnimatedSprite2D.flip_h = 1
		$AnimatedSprite2D.animation = "walk"
	elif Input.is_action_pressed("ui_right"):
		position += 3*Math.rotate_vector(Vector2(1, 0), collider_node.get_active_sensor_bottom().get_angle())
		$AnimatedSprite2D.flip_h = 0
		$AnimatedSprite2D.animation = "walk"
	else:
		#velocity.x = 0
		$AnimatedSprite2D.animation = "stand"
	if Input.is_action_just_pressed("ui_up"):
		#velocity = -7*Math.rotate_vector(Vector2(0, 1), collider_node.get_active_sensor_bottom().get_angle())
		velocity.y = -7
		pass
	
	#velocity = Vector2(0, 0)
	apply_velocity()
	#position.x += 3
	Math.player_pos = to_global(collider_node.get_active_sensor_bottom().get_distance())
	
	#rotation = -collider_node.get_active_sensor_bottom().get_angle()
	
	#position += Math.rotate_vector(Math.obj_pos - Math.player_pos, 0.001, true)
	collide()

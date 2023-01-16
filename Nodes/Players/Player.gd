extends Entity

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity.x += -0.2*sin(global_rotation)
	velocity.y += 0.2*cos(global_rotation)
	if Input.is_action_pressed("ui_left"):
		position.x -= 3
		$AnimatedSprite2D.flip_h = 1
		$AnimatedSprite2D.animation = "walk"
	elif Input.is_action_pressed("ui_right"):
		position.x += 3
		$AnimatedSprite2D.flip_h = 0
		$AnimatedSprite2D.animation = "walk"
	else:
		#velocity.x = 0
		$AnimatedSprite2D.animation = "stand"
	if Input.is_action_just_pressed("ui_up"):
		velocity.y = -7
		pass
	
	position += velocity
	#position.x += 3
	collide()

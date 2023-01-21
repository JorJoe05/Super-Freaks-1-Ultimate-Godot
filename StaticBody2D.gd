extends Entity


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	#angular_velocity = 0.01
	Math.obj_pos = global_position
	#print(Math.rotate_vector(Vector2(1, 0), angular_velocity, true))
	apply_angular_velocity()

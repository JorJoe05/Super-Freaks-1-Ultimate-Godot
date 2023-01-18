extends Entity

var prog : float

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	prog += 0.02
	velocity.x = cos(prog)
	velocity.y = sin(prog)
	apply_velocity()

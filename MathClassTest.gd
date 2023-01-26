extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	$Vector.set_point_position(0, flatten_vector($Vector.get_point_position(0), $Target.get_point_position(0)))

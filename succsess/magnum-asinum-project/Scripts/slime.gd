extends Node2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += 60 * delta #One pixel per second, delta makes this even, even if fps differenciates.
	

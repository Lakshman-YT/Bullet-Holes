extends KinematicBody
var Health  = 100

func _process(delta):
	if Health <= 0 :
		queue_free()

extends Spatial

onready var concrete = $concrete
onready var glass = $glass

var types = ["1" , "2"]
var can_erase = false
var bullethole

func _ready():
	randomize()

func showhole(type):
	match type:
		"concrete":
			rotatetex(concrete)
		"glass":
			rotatetex(glass)
		_:
			pass

func rotatetex(tex):
	tex.visible = true
	tex.animation = types[ randi() % types.size()]
	tex.rotation_degrees.z = rand_range(0 , 360)
	if randi() % 2:
		tex.flip_h = true
	yield(get_tree().create_timer(3) , "timeout")
	can_erase = true
	bullethole = tex
	
	
func _process(delta):
	if can_erase:
		bullethole.modulate.a = lerp(bullethole.modulate.a , 0 , 2 *delta)
		if bullethole.modulate.a == 0:
			queue_free()

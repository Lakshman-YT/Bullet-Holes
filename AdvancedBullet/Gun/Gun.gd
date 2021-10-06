extends Spatial

onready var camcast = $"../../Camera/camcast"
onready var muzzle = $Muzzle
onready var bullet = preload("res://Bullet/Bullet.tscn")

var canfire = true

func _ready():
	pass
#############              GW TUTS
func _process(delta):
	if Input.is_action_pressed("fire") and canfire:
		if camcast.is_colliding():
			var bull = bullet.instance()
			muzzle.add_child(bull)
			bull.look_at(camcast.get_collision_point(), Vector3(0,0,1))
			
			canfire = false
			yield(get_tree().create_timer(0.25) ,"timeout")
			canfire = true

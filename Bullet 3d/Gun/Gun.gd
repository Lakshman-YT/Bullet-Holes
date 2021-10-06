extends Spatial

onready var muzzle = $Muzzle
onready var cam_cast = $"../../Camera/cam_cast"
onready var bull = preload("res://Bullet/Bullet.tscn")

var can_fire = true

func _ready():
	pass

func _physics_process(delta):
	if Input.is_action_pressed("fire") and can_fire:
		if cam_cast.is_colliding():
			var bullet = bull.instance()
			muzzle.add_child(bullet)
			bullet.look_at(cam_cast.get_collision_point(), Vector3.UP)
			bullet.shoot(delta)
			can_fire = false
			yield(get_tree().create_timer(0.25) ,"timeout")
			can_fire = true
			
			

		

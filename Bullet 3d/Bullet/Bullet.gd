extends RigidBody

const DAMAGE = 50
const SPEED = 50

onready var collider = $collider

onready var bh = preload("res://BulletHole/BulletHole.tscn")

func _ready():
	set_as_toplevel(true)
	

func shoot(delta):
	apply_impulse(transform.basis.z, -transform.basis.z * SPEED) 



func _process(delta):
	if collider.is_colliding():
		var collisionbody = collider.get_collider()
		var bulletHole = bh.instance()
		collisionbody.add_child(bulletHole)
		bulletHole.global_transform.origin = collider.get_collision_point()
		bulletHole.look_at(collider.get_collision_point() + collider.get_collision_normal() , Vector3.UP )
		if collisionbody.is_in_group("concrete"):
			bulletHole.showhole("concrete")
		if collisionbody.is_in_group("glass"):
			bulletHole.showhole("glass")
			
		if collisionbody.is_in_group("enemy"):
			collisionbody.Health -= DAMAGE
		queue_free()

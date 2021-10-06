extends Spatial

onready var timer = $Timer
onready var raycast = $RayCast
onready var bullet = $"."
onready var bh = preload("res://BulletHole/BulletHole.tscn")


var ms = 0
var s = 0
var realtime = 0

var path = 0
var speed = 0
var collision_body
var damage = 100

func _ready():
	set_as_toplevel(true)
	timer.start()

func _on_Timer_timeout():
	ms += 1
	if ms >= 10:
		s += 1
		ms = 0
	realtime = s + (ms * 0.1)
	
	
	
#############              GW TUTS   ########################################
func _process(delta):
	
	if raycast.is_colliding():
		collision_body = raycast.get_collider()
		path = (raycast.get_collision_point() - bullet.transform.origin).length()
		speed = path / 100
		if abs(speed - realtime) <= 0.1:
			var Bullethole = bh.instance()
			collision_body.add_child(Bullethole)
			Bullethole.global_transform.origin = raycast.get_collision_point()
			Bullethole.look_at(raycast.get_collision_point() + raycast.get_collision_normal() , Vector3.UP )
			if collision_body.is_in_group("concrete"):
				Bullethole.showhole("concrete")
			if collision_body.is_in_group("glass"):
				Bullethole.showhole("glass")
			if collision_body.is_in_group("enemy"):
				collision_body.Health -= damage
				queue_free()
			queue_free()
	

extends Area2D
var speed = 1
export var damage = 1
var lifeFrames = 100
onready var rot = Vector2.UP.rotated(rotation)

func _ready():
	connect("body_entered", self, "hit_body")
	$RayCast2D.cast_to.y = -speed

func _physics_process(_delta):
	if lifeFrames <= 0:
		queue_free()
		return
	else:
		lifeFrames-=1
	global_translate(speed*rot)
	check_future()

func check_future():
	if $RayCast2D.is_colliding():
		hit_body($RayCast2D.get_collider())

func hit_body(body):
	if body.is_in_group("body_part"):
		body.hit(damage)
		body.bleed(tan(rotation))
	queue_free()

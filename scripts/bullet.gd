extends Area2D
var speed = 1
export var damage = 1
var lifeFrames = 100
onready var rot = Vector2.UP.rotated(rotation)

func _ready():
	connect("body_entered", self, "hit_body")

func _physics_process(delta):
	if lifeFrames > 0:
		lifeFrames-=1
	else:
		queue_free()
		return
	global_translate(speed*rot)

func hit_body(body):
	if body.is_in_group("body_part"):
		body.hit(damage)
	queue_free()

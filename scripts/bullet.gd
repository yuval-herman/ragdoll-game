extends Area2D
var speed = 1
export var damage = 1
const maxLifeFrames = 50
var lifeFrames = maxLifeFrames
onready var rot = Vector2.UP.rotated(rotation)
var shape_calculated = false
const bias = 1/60.0

func _ready():
	connect("body_entered", self, "hit_body")
	if not shape_calculated:
		calc_shape()

func calc_shape():
	shape_calculated = true
	$CollisionShape2D.shape.radius = 6
	$CollisionShape2D.shape.height = speed
	$CollisionShape2D.position.y -= speed/2

func _physics_process(delta):
	var db = delta/bias
	if lifeFrames <= 0:
		disapear()
		return
	else:
		lifeFrames-=1*db
	global_translate(speed*rot*db)

func hit_body(body):
	if body.is_in_group("body_part"):
		body.hit(damage, tan(rotation))
	disapear()

func go():
	lifeFrames = maxLifeFrames
	rot = Vector2.UP.rotated(rotation)
	show()
	set_deferred("monitorable", true)
	set_deferred("monitoring", true)
	set_physics_process(true)
	set_physics_process_internal(true)
	set_process(true)
	set_process_input(true)
	set_process_internal(true)
	set_process_unhandled_input(true)
	set_process_unhandled_key_input(true)

func disapear():
	hide()
	set_deferred("monitorable", false)
	set_deferred("monitoring", false)
	set_physics_process(false)
	set_physics_process_internal(false)
	set_process(false)
	set_process_input(false)
	set_process_internal(false)
	set_process_unhandled_input(false)
	set_process_unhandled_key_input(false)

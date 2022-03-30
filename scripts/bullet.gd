extends Sprite
var speed = 1
export var damage = 1
const maxLifeFrames = 50
var lifeFrames = maxLifeFrames
onready var rot = Vector2.UP.rotated(rotation)
const bias = 1/60.0

func _physics_process(delta):
	var db = delta/bias
	if lifeFrames <= 0:
		disapear()
		return
	else:
		lifeFrames-=1*db
	$RayCast2D.cast_to.y = -speed*db
	global_translate(speed*rot*db)
	if $RayCast2D.is_colliding():
		hit_body($RayCast2D.get_collider())

func hit_body(body):
	if body.is_in_group("body_part"):
		body.hit(damage, tan(rotation))
	disapear()

func go():
	lifeFrames = maxLifeFrames
	rot = Vector2.UP.rotated(rotation)
	show()
	set_physics_process(true)
	set_physics_process_internal(true)
	set_process(true)
	set_process_input(true)
	set_process_internal(true)
	set_process_unhandled_input(true)
	set_process_unhandled_key_input(true)

func disapear():
	hide()
	set_physics_process(false)
	set_physics_process_internal(false)
	set_process(false)
	set_process_input(false)
	set_process_internal(false)
	set_process_unhandled_input(false)
	set_process_unhandled_key_input(false)

extends "res://scripts/dragablle.gd"
export (PackedScene) var bullet
var shooting = false

func _physics_process(delta):
	if shooting:
		shoot()

func shoot():
	var bull = bullet.instance()
	bull.rotation = rotation
	bull.global_position = $muzzle.global_position
	bull.speed = 100
	bull.damage = 10
	$"/root".call_deferred("add_child" ,bull)

func _input(event):
	if event.is_action_pressed("right click"):
		shooting=true
	elif event.is_action_released("right click"):
		shooting=false

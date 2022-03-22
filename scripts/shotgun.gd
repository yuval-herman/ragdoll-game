extends "res://scripts/dragablle.gd"
export (PackedScene) var bullet
var shooting = false
var shootrate = 45 #bigger=slower
var wait_frames = 0
var cluster_size = 5

func _physics_process(_delta):
	if wait_frames > 0:
		wait_frames-=1
	elif shooting:
		shoot()

func shoot():
	wait_frames = shootrate
	for i in range(5):
		var bull = bullet.instance()
		bull.rotation = rotation*rand_range(.98, 1.02)
		bull.global_position = $muzzle.global_position
		bull.speed = 100*rand_range(.98, 1.02)
		bull.damage = 10
		$"/root".call_deferred("add_child" ,bull)

func _input(event):
	if event.is_action_pressed("right click") and wait_frames == 0:
		shoot()
		shooting=true
	elif event.is_action_released("right click"):
		shooting=false

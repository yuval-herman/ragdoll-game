extends RigidBody2D
export (PackedScene) var bullet = preload("res://scenes/bullet.tscn")
var shooting = false
const shootrate = 30 #bigger=slower
var wait_frames = 0
const cluster_size = 15
var bulletPool = []
var currBullet = 0
const maxBullets = cluster_size*5

func _ready():
	for i in maxBullets:
		bulletPool.append(bullet.instance())
		bulletPool[i].damage = 10
		bulletPool[i].speed = 100*rand_range(.98, 1.02)
		$"/root".call_deferred("add_child" ,bulletPool[i])

func _physics_process(_delta):
	if wait_frames > 0:
		wait_frames-=1
	elif shooting:
		shoot()

func take_bullet():
	currBullet+=1
	if currBullet == maxBullets:
		currBullet=0
	return bulletPool[currBullet]

func shoot():
	wait_frames = shootrate
	for i in cluster_size:
		var bull = take_bullet()
		bull.rotation = rotation*rand_range(.98, 1.02)
		bull.global_position = $muzzle.global_position
		bull.go()

func _input_event(_viewport, event, _shape_idx):
	if event.is_action_pressed("right click") and wait_frames == 0:
		shoot()
		shooting=true
	elif event.is_action_released("right click"):
		shooting=false

extends Node

class_name Shootable

export (float) var shootrate
export (int) var cluster_size
export (int) var maxBullets #higer is slower
export (PackedScene) var bullet := preload("res://scenes/bullet.tscn")
export (NodePath) var muzzle

var shooting := false
var can_shoot := true
var bulletPool := []
var currBullet := 0


onready var parent := get_parent()

func _ready():
	$Timer.wait_time = shootrate
	muzzle = get_node(muzzle)
	parent.connect("input_event", self, "input_event")
	for i in maxBullets:
		bulletPool.append(bullet.instance())
		bulletPool[i].damage = 10
		bulletPool[i].speed = 100*rand_range(.98, 1.02)
		$"/root".call_deferred("add_child" ,bulletPool[i])

func _physics_process(_delta):
	if shooting and can_shoot:
		shoot()

func shoot():
	can_shoot = false
	$Timer.start()
	for i in cluster_size:
		var bull = take_bullet()
		bull.rotation = parent.rotation*rand_range(.98, 1.02)
		bull.global_position = muzzle.global_position
		bull.go()

func take_bullet():
	currBullet+=1
	if currBullet == maxBullets:
		currBullet=0
	return bulletPool[currBullet]

func input_event(_viewport, event, _shape_idx):
	if event.is_action_pressed("right click") and can_shoot:
		shoot()
		shooting=true

func _input(event):
	if event.is_action_released("right click"):
		shooting=false

func _on_Timer_timeout():
	can_shoot = true

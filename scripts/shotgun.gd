extends "res://scripts/dragablle.gd"
export (PackedScene) var bullet

func shoot():
	var bull = bullet.instance()
	bull.dir = Vector2.UP*2
	$"/root".call_deferred("add_child" ,bull)

#func _ready():
#	shoot()

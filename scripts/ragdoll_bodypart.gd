extends "res://scripts/dragablle.gd"
export var life = 100

signal died

func _process(_delta):
	if life <= 0:
		die()

func _ready():
	connect("body_entered", self, "hit_object")

func die():
	emit_signal("died", self)
	queue_free()

func hit_object(body):
	if not body.is_in_group("body_part"):
		var strength = Helpers.sum(linear_velocity)/50
		life-=strength

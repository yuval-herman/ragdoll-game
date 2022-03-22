extends "res://scripts/dragablle.gd"
export var life = 100
export (PackedScene) var blood = load("res://scenes/blood.tscn")

signal died

func _process(_delta):
	if life <= 0:
		die()

func _ready():
	connect("body_entered", self, "hit_object")
	add_to_group("body_part")

func die():
	emit_signal("died", self)
	queue_free()

func hit(damage):
	life-=damage

func bleed(dir):
	var bl = blood.instance()
	bl.emitting = true
	bl.global_position = global_position
	bl.rotation = dir
	$"/root".call_deferred("add_child", bl)

func hit_object(body):
	if not body.is_in_group("body_part"):
		var strength = Helpers.sum(linear_velocity)/50
		life-=strength

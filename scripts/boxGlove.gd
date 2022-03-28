extends "res://scripts/dragablle.gd"
var attached_pin

func _physics_process(_delta):
	if attached_pin:
		global_rotation = attached_pin.global_rotation+PI/2
	elif is_held:
		rotation = linear_velocity.angle() + PI

func attach(pin):
	attached_pin = pin

func dittach():
	attached_pin = null

func _input(event):
	if event.is_action_pressed("right click") and is_held:
		set_axis_velocity(linear_velocity*20)

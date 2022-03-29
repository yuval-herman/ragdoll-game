extends RigidBody2D

var attached_pin: HoldPin
onready var dragabble: Draggable = $draggable

func _physics_process(_delta):
	if attached_pin:
		global_rotation = attached_pin.global_rotation+PI/2
	elif dragabble.is_held:
		rotation = linear_velocity.angle() + PI

func attach(pin: HoldPin):
	attached_pin = pin

func dittach():
	attached_pin = null

func _input(event: InputEvent):
	if event.is_action_pressed("right click") and dragabble.is_held:
		set_axis_velocity(linear_velocity*20)

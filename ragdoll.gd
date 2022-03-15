extends Node2D
var stand_force = 70
onready var head = $head
onready var rleg = $"r leg 2"
onready var lleg = $"l leg 2"
var parts_touching_ground = []
var held_object = null

func _ready():
	for i in get_children():
		if i.is_in_group("body_part"):
			i.connect("body_entered", self, "hit_object")
			i.connect("body_exited", self, "stop_touching")
			i.connect("clicked", self, "_on_bodypart_clicked")

func _process(delta):
	print(stand_force)
	if not parts_touching_ground.empty():
		head.set_axis_velocity(Vector2.UP*stand_force)
		rleg.set_axis_velocity(-Vector2.UP*stand_force)
		lleg.set_axis_velocity(-Vector2.UP*stand_force)

func hit_object(body):
	if body.is_in_group("ground"):
		parts_touching_ground.append(body)

func stop_touching(body):
	if body.is_in_group("ground"):
		parts_touching_ground.erase(body)

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if held_object and !event.pressed:
			held_object.drop()
			held_object = null

func _on_bodypart_clicked(object):
	if !held_object:
		held_object = object
		held_object.pickup()

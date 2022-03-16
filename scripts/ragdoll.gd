extends Node2D
var parts_touching_ground = []
var upper_body_parts = []
var alive = true
var held_object = null
var stand_force = 10
var is_slomo = false

func _ready():
	for i in get_children():
		if i.is_in_group("body_part"):
			i.connect("body_entered", self, "hit_object")
			i.connect("body_exited", self, "stop_touching")
			i.connect("clicked", self, "_on_bodypart_clicked")
			i.connect("died", self, "_on_part_died")
			if not "leg" in i.name and not "hand" in i.name:
				upper_body_parts.append(i)

func _physics_process(delta):
#	if not alive:
#		fall()
#		set_process(false)
	if not parts_touching_ground.empty():
		stand()
	else:
		fall()

func stand():
	for i in upper_body_parts:
		i.gravity_scale = -stand_force*.5
	if is_instance_valid($"r leg 2"):
		$"r leg 2".gravity_scale = stand_force
	if is_instance_valid($"l leg 2"):
		$"l leg 2".gravity_scale = stand_force

func fall():
	for i in upper_body_parts:
		i.gravity_scale = 1

func hit_object(body):
	if body.is_in_group("ground"):
		parts_touching_ground.append(body)

func stop_touching(body):
	if body.is_in_group("ground"):
		parts_touching_ground.erase(body)

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if held_object and !event.pressed:
			if is_instance_valid(held_object):
				held_object.drop()
			held_object = null

func _on_bodypart_clicked(object):
	if !held_object:
		held_object = object
		held_object.pickup()

func _on_part_died(part):
	upper_body_parts.erase(part)
	alive=false

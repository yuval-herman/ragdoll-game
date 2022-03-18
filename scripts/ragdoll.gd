extends Node2D
var ground_being_touched = []
var touching_ground = []
onready var body_parts = get_tree().get_nodes_in_group("body_part")
var alive = true
var held_object = null
var stand_force = 10
var is_slomo = false

func _ready():
	for i in get_children():
		if i.is_in_group("body_part"):
			i.connect("body_entered", self, "hit_object", [i])
			i.connect("body_exited", self, "stop_touching", [i])
			i.connect("clicked", self, "_on_bodypart_clicked")
			i.connect("died", self, "_on_part_died")

func _physics_process(delta):
	if not alive:
		set_process(false)

func hit_object(body, rigidbody):
	if body.is_in_group("ground"):
		ground_being_touched.append(body)
		touching_ground.append(rigidbody)
		for body in body_parts:
			if is_instance_valid(body):
				body.gravity_scale = -stand_force/5
			else:
				body_parts.erase(body)
		for body in touching_ground:
			if is_instance_valid(body):
				body.gravity_scale = stand_force*2
			else:
					touching_ground.erase(body)

func stop_touching(body, rigidbody):
	if body.is_in_group("ground"):
		ground_being_touched.erase(body)
		touching_ground.erase(rigidbody)
		if touching_ground:
			for body in body_parts:
				if is_instance_valid(body):
					body.gravity_scale = -stand_force/5
				else:
					body_parts.erase(body)
			for body in touching_ground:
				if is_instance_valid(body):
					body.gravity_scale = stand_force*2
				else:
					touching_ground.erase(body)
		else:
			for body in body_parts:
				body.gravity_scale = 1
		

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
	alive=false

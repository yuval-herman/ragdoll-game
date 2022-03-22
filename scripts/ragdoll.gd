extends Node2D
var touching_ground = []
onready var body_parts = get_tree().get_nodes_in_group("body_part")
var alive = true
var stand_force = 5
var is_slomo = false

func _ready():
	for i in get_children():
		if i.is_in_group("body_part"):
			i.connect("body_entered", self, "hit_object", [i])
			i.connect("body_exited", self, "stop_touching", [i])
			i.connect("died", self, "_on_part_died")

func _physics_process(_delta):
	if not alive:
		set_process(false)

func hit_object(body, rigidbody):
	if body.is_in_group("ground"):
		touching_ground.append([rigidbody, body])
		for body in body_parts:
			if is_instance_valid(body):
				body.gravity_scale = -stand_force/5
			else:
				body_parts.erase(body)
		for pair in touching_ground:
			if is_instance_valid(pair[0]):
				pair[0].gravity_scale = stand_force*2
			else:
					touching_ground.erase(pair)

func stop_touching(body, rigidbody):
	if body.is_in_group("ground"):
		touching_ground.erase([rigidbody, body])
		if touching_ground:
			for body in body_parts:
				if is_instance_valid(body):
					body.gravity_scale = -stand_force/5
				else:
					body_parts.erase(body)
			for pair in touching_ground:
				if is_instance_valid(pair[0]):
					pair[0].gravity_scale = stand_force*3
				else:
					touching_ground.erase(pair)
		else:
			for body in body_parts:
				if is_instance_valid(body):
					body.gravity_scale = 1
				else:
					body_parts.erase(body)

func _on_part_died(_part):
	alive=false

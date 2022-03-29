extends Node2D
var touching_ground = []
onready var not_touching_ground = []
var alive = true
var stand_force = 5
var stand_lower_force = 50

func _ready():
	set_process(false)
	for i in get_children():
		if i.is_in_group("body_part"):
			not_touching_ground.append(i)
			i.connect("body_entered", self, "hit_object", [i])
			i.connect("body_exited", self, "stop_touching", [i])
			i.connect("died", self, "_on_part_died")

func hit_object(otherbody, body):
	if not alive:
		return
	if otherbody.is_in_group("ground"):
		touching_ground.append(body)
		not_touching_ground.erase(body)
		for body in not_touching_ground:
			if is_instance_valid(body):
				body.gravity_scale = -stand_force
			else:
				not_touching_ground.erase(body)
		for body in touching_ground:
			if is_instance_valid(body):
				body.gravity_scale = stand_lower_force
			else:
				touching_ground.erase(body)

func stop_touching(otherbody, body):
	if not alive:
		return
	if otherbody == null or otherbody.is_in_group("ground"):
		touching_ground.erase(body)
		not_touching_ground.append(body)
		if not touching_ground:
			for body in not_touching_ground:
				if is_instance_valid(body):
					body.gravity_scale = 1
				else:
					not_touching_ground.erase(body)

func fall(deadpart=null):
	touching_ground.erase(deadpart)
	not_touching_ground.erase(deadpart)
	for body in touching_ground+not_touching_ground:
		if is_instance_valid(body):
			body.gravity_scale = 1

func _on_part_died(part):
	fall(part)
	alive=false

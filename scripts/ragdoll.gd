extends Node2D
var parts_touching_ground = []
var alive = true
var held_object = null
var stand_force = 10
var is_slomo = false

func _ready():
	print(test())
	for i in get_children():
		if i.is_in_group("body_part"):
			i.connect("body_entered", self, "hit_object")
			i.connect("body_exited", self, "stop_touching")
			i.connect("clicked", self, "_on_bodypart_clicked")
			i.connect("died", self, "_on_part_died")

func _physics_process(delta):
	if not alive:
		set_process(false)

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
	alive=false

func test():
	var body_tree = Tree_node.new("head")
	body_tree.add_child(Tree_node.new("body1"))
	body_tree.child_array[0].add_child(Tree_node.new("l hand 1"))
	body_tree.child_array[0].add_child(Tree_node.new("r hand 1"))
	body_tree.child_array[0].add_child(Tree_node.new("body2"))
	body_tree.child_array[0].child_array[0].add_child(Tree_node.new("body3"))
	return body_tree

class_name Tree_node

var info
var parent
var child_array = []

func _init(info, parent=null):
	self.info = info
	self.parent = parent

func add_child(child):
	child.parent = self
	child_array.append(child)

func _to_string():
	if child_array.empty():
		return str(info)
	else:
		return str(info)+"\n"+str(child_array)

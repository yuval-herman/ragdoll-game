extends Node

class_name Helpers

static func sum(arr):
	var ret=0
	for i in arr:
		ret+=i
	return ret

static func wait_for_unpause(tree):
	yield(tree, "idle_frame")
	while(tree.paused):
		yield(tree, "idle_frame")

static func dir_contents(path) -> Array:
	var files := []
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				print("Found directory: " + file_name)
			else:
				files.append(file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	return files

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

static func is_outside_view_bounds(pos):
	var scr_size = OS.get_screen_size()
	print(scr_size, pos)
	return pos.x>scr_size.x or pos.x<0.0 or pos.y>scr_size.y or pos.y<0.0

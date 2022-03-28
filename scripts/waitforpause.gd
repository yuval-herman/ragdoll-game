extends Node

func return_when_upaused():
	yield(get_tree(), "idle_frame")

extends Camera2D
export var push_speed = 10
onready var view = get_viewport()

func _process(_delta):
	var mp=view.get_mouse_position()/view.size
	if mp.y<.05: #up
		position.y-=push_speed
	elif mp.y>.95: #down
		position.y+=push_speed
	if mp.x<.035: #left
		position.x-=push_speed
	elif mp.x>.95: #rigth
		position.x+=push_speed

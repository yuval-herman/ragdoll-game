extends Camera2D
var push_speed = 10

func _process(delta):
	var mp=get_local_mouse_position()
	if mp.y<-200:
		position.y-=push_speed
	elif mp.y>200:
		position.y+=push_speed
	if mp.x<-400:
		position.x-=push_speed
	elif mp.x>400:
		position.x+=push_speed

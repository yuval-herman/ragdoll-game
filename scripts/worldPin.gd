extends Node2D

func _draw():
	draw_circle(Vector2(), 10, Color(1,1,1))

#func _ready():
#	yield(get_tree(), "physics_frame")
#	yield(get_tree(), "physics_frame")
#	print($Area2D.get_overlapping_bodies())


func _on_Area2D_body_entered(body):
	print($Area2D.get_overlapping_bodies())
	var rem = $Area2D
	remove_child($Area2D)
	rem.queue_free()

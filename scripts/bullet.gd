extends Area2D
var dir

func _ready():
	position = Vector2(1,1)

func _physics_process(delta):
	position *= dir

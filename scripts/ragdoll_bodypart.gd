extends RigidBody2D
export var life = 1000
onready var blood = preload("res://scenes/blood.tscn")
onready var draggable: Draggable = preload("res://script components/draggable.tscn").instance()
var bloods = []
var currBlood = 0
const bloodMax = 3

signal rclicked
signal died
var bodystate:Physics2DDirectBodyState

func _ready():
	for i in get_children():
		if i.is_in_group("holdPin"):
			connect("rclicked", i, "toggle")
	for i in bloodMax:
		bloods.push_back(blood.instance())
		$"/root".call_deferred("add_child", bloods[i])
	connect("body_entered", self, "hit_object")
	add_to_group("body_part")
	add_child(draggable)

func _process(_delta):
	if life <= 0:
		die()

func _integrate_forces(state):
	self.bodystate = state

func _input_event(_viewport, event, _shape_idx):
	if event.is_action_pressed("right click"):
		emit_signal("rclicked")

func die():
	emit_signal("died", self)
	queue_free()

func hit(damage, dir):
	life-=damage
	bleed(damage, dir)

func get_blood():
	currBlood+=1
	if currBlood == bloodMax:
		currBlood = 0
	return bloods[currBlood]

func bleed(damage, dir):
	var bl = get_blood()
	var amount = int(log(damage))*20
	if amount < 1:
		return
	bl.amount = amount
	bl.initial_velocity = log(damage)*200
	bl.spread = damage
	bl.emitting = true
	bl.global_position = global_position
	bl.global_rotation = dir

func hit_object(body):
	if not body.is_in_group("body_part"):
		var strength = linear_velocity.length()/100
		if strength < 1:
			return
		life-=strength
		if strength>0:
			bleed(strength, bodystate.get_contact_local_normal(0).angle()+PI/2)

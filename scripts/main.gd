extends Node2D

const spawRate = 10 # higer is slower

enum MouseModes {DRAG, PIN, SPAWN, BOX}

var is_slomo = false
var spawning = false
var held_object = null
var mouseMode = MouseModes.DRAG
var items = []
var spawn_wait = 0
var time_scale = 1.0

onready var pin = preload("res://scenes/worldPin.tscn")
onready var boxGlove = preload("res://scenes/items/boxGlove.tscn")
onready var spawnObj = preload("res://scenes/ragdoll.tscn")

func _init():
	Singleton.main = self

func _ready():
	$"CanvasLayer/HSplitContainer/VBoxContainer/ItemList".add_item("ragdoll")
	for item in Helpers.dir_contents(Singleton.ITEMS_PATH):
		$"CanvasLayer/HSplitContainer/VBoxContainer/ItemList".add_item(item.replace('.tscn', ''))

func _process(delta):
	if spawning and spawn_wait<=0:
		spawn_obj()
		spawn_wait=spawRate
	if spawn_wait>0:
		spawn_wait-=1

func _input(event):
	if event.is_action_pressed("mode drag"):
		change_mouse_mode(MouseModes.DRAG)
	elif event.is_action_pressed("mode pin"):
		change_mouse_mode(MouseModes.PIN)
	elif event.is_action_pressed("mode spawn"):
		change_mouse_mode(MouseModes.SPAWN)
	elif event.is_action_pressed("mode box"):
		change_mouse_mode(MouseModes.BOX)
	elif event.is_action_pressed("slomo"):
		toggle_slomo()
	elif event.is_action_released("speed up"):
		speedup()
	elif event.is_action_released("slow down"):
		slowdown()
	elif event.is_action_released("pause"):
		get_tree().paused = !get_tree().paused;
	elif event.is_action_pressed("zoom_in"):
		zoom(.5)
	elif event.is_action_pressed("zoom_out"):
		zoom(2)
	elif event.is_action_pressed("reset camera"):
		reset_camera()
	elif event.is_action("left click"):
		left_click_mode_handle(event)
	elif event.is_action("right click"):
		right_click_mode_handle(event)

func right_click_mode_handle(event):
	pass
#	if event.is_pressed():
#		match mouseMode:
#			MouseModes.DRAG:
#				if is_instance_valid(held_object) and !held_object.is_in_group("guns") and is_slomo:
#					held_object.follow_mouse_strength /= time_scale
#	else:
#		match mouseMode:
#			MouseModes.DRAG:
#				if is_instance_valid(held_object) and !held_object.is_in_group("guns") and is_slomo:
#					held_object.follow_mouse_strength = 50

func left_click_mode_handle(event):
	if event.is_pressed():
		match mouseMode:
			MouseModes.SPAWN:
				spawning = true
			MouseModes.BOX:
				spawn_obj(boxGlove)
	else:
		match mouseMode:
			MouseModes.SPAWN:
				spawning = false
			MouseModes.DRAG:
				drop_held()

func _on_clicked(object):
	if mouseMode == MouseModes.PIN:
		var npin = spawn_obj(pin)
		npin.pinn_object(object.get_parent()) #TODO: use a pinnable component?
	elif mouseMode == MouseModes.DRAG:
		pickup_held(object)

func drop_held():
	if !is_instance_valid(held_object):
		return
	held_object.drop()
	held_object = null

func pickup_held(obj):
	if is_instance_valid(held_object):
		return
	held_object = obj
	held_object.pickup()

func change_mouse_mode(mode):
	drop_held()
	mouseMode = mode
	$"CanvasLayer/HSplitContainer/VBoxContainer/HBoxContainer/mouseModeLable".text = MouseModes.keys()[mode]

func spawn_obj(Obj=spawnObj):
	var newObj = Obj.instance()
	newObj.global_position = get_global_mouse_position()
	add_child(newObj)
	return newObj

func zoom(zoom):
	$Camera2D.global_position = get_global_mouse_position()
	$Camera2D.zoom *= zoom

func reset_camera():
	$Camera2D.zoom = Vector2(2,2)
	$Camera2D.position=Vector2.ZERO
	$Camera2D.smoothing_enabled=false
	yield(get_tree(), "idle_frame")
	$Camera2D.smoothing_enabled=true

func speedup():
	$Camera2D.smoothing_enabled = false
	time_scale *= 2
	Engine.time_scale = time_scale
	is_slomo = true
	$CanvasLayer/HSplitContainer/VBoxContainer/HBoxContainer/speedlabel.text = str(Engine.time_scale)

func slowdown():
	$Camera2D.smoothing_enabled = false
	time_scale /= 2
	Engine.time_scale = time_scale
	is_slomo = true
	$CanvasLayer/HSplitContainer/VBoxContainer/HBoxContainer/speedlabel.text = str(Engine.time_scale)

func toggle_slomo():
	if is_slomo:
		$Tween.interpolate_property(Engine, "time_scale", null, 1.0, 1.0)
		
		$Tween.start()
		$Camera2D.smoothing_enabled = true
	else:
		$Tween.interpolate_property(Engine, "time_scale", null, time_scale, 1.0)
		$Tween.start()
		$Camera2D.smoothing_enabled = false
	$CanvasLayer/HSplitContainer/VBoxContainer/HBoxContainer/speedlabel.text = str(Engine.time_scale)
	is_slomo = !is_slomo


func _on_Tween_tween_step(object, key, elapsed, value):
	if object == Engine:
		$CanvasLayer/HSplitContainer/VBoxContainer/HBoxContainer/speedlabel.text = str(Engine.time_scale)

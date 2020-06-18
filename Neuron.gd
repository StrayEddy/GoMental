extends Node2D

signal is_selected


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func selected():
	emit_signal("is_selected")

func _on_Area2D_mouse_entered():
	$CircleSprite.self_modulate = Color(.5,.5,.5)
	$CircleSprite/PlusSprite.self_modulate = Color(1,1,1)

func _on_Area2D_mouse_exited():
	$CircleSprite.self_modulate = Color(1,1,1)
	$CircleSprite/PlusSprite.self_modulate = Color(0,0,0)

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		selected()

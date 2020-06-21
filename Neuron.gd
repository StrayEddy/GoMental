extends Node2D

signal is_selected(neuron)
signal is_moving(position)

var dragging = false
var father = null


func _ready():
	pass # Replace with function body.

func _process(delta):
	if dragging:
		var mousepos = get_viewport().get_mouse_position()
		self.position = Vector2(mousepos.x, mousepos.y)
		emit_signal("is_moving", self.position)

func get_label():
	return $CircleSprite/CenterContainer/Label.text

func set_label(text):
	$CircleSprite/CenterContainer/Label.text = text
	show_label()
	hide_plus()

func set_father(neuron):
	father = neuron
	self.position = father.position + Vector2(0,150)

func show_label():
	$CircleSprite/CenterContainer.show()

func hide_label():
	$CircleSprite/CenterContainer.hide()

func show_plus():
	$CircleSprite/PlusSprite.show()

func hide_plus():
	$CircleSprite/PlusSprite.hide()

func selected():
	emit_signal("is_selected", self)

func _on_Area2D_mouse_entered():
	$CircleSprite.self_modulate = Color(1,1,1)
	$CircleSprite/PlusSprite.self_modulate = Color(0,0,0)
	$CircleSprite/CenterContainer/Label.set("custom_colors/font_color", Color(0,0,0))

func _on_Area2D_mouse_exited():
	$CircleSprite.self_modulate = Color(0.5,0.5,0.5)
	$CircleSprite/PlusSprite.self_modulate = Color(1,1,1)
	$CircleSprite/CenterContainer/Label.set("custom_colors/font_color", Color(1,1,1))

func _on_Area2D_input_event(viewport, event, shape_idx):
	get_tree().set_input_as_handled()
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			dragging = true
		elif event.button_index == BUTTON_LEFT and !event.pressed:
			dragging = false
		elif event.button_index == BUTTON_RIGHT and event.pressed:
			selected()

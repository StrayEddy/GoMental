extends Sprite

var dragging = false
var mousePos

func _process(delta):
	if dragging:
		var newMousePos = get_viewport().get_mouse_position()
		var deltaPos = newMousePos - mousePos
		$Camera2D.position -= deltaPos
#		self.position -= deltaPos
		mousePos = newMousePos

func _input(event):
	for neuron in get_tree().get_nodes_in_group("Neuron"):
		if neuron.mousein:
			return
	
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			dragging = event.pressed
			mousePos = get_viewport().get_mouse_position()

extends Node2D

var neuron_scene = load("res://Neuron.tscn")

func _ready():
	$Neuron.connect("is_selected", self, "put_focus_on_line_edit")

func put_focus_on_line_edit():
	$GridContainer/LineEdit.clear()
	$GridContainer/LineEdit.grab_focus()

func _on_LineEdit_text_entered(new_text):
	$GridContainer/LineEdit.clear()
	var neuron = neuron_scene.instance()
	neuron.position = Vector2(100,100)
	add_child(neuron)

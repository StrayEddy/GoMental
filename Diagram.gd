extends Node2D

const ZOOM_SENSITIVITY = Vector2(.05, .05)

var neuron_scene = load("res://Neuron.tscn")
var connexion_scene = load("res://Connexion.tscn")
var selected_neuron


func _ready():
	selected_neuron = $MainNeuron
	$MainNeuron.connect("is_selected", self, "neuron_is_selected")

func build(root):
	for child in root:
		if child.is_leaf():
			build_leaf(child, root)
		else:
			build(child)

func build_leaf(leaf, parent):
	pass

func neuron_is_selected(neuron):
	selected_neuron = neuron
	$CanvasLayer/SearchBar.show()
	put_focus_on_line_edit()

func put_focus_on_line_edit():
	$CanvasLayer/SearchBar/LineEdit.clear()
	$CanvasLayer/SearchBar/LineEdit.grab_focus()
	var suggestions = SearchEngine.get_suggestions(selected_neuron.get_label())
	$CanvasLayer/SearchBar.set_suggestions(suggestions)

func add_neuron(text):
	# Add neuron
	var neuron = neuron_scene.instance()
	neuron.connect("is_selected", self, "neuron_is_selected")
	neuron.set_label(text)
	neuron.set_father(selected_neuron)
	add_child(neuron)
	
	# Add connection to father neuron
	create_connection_with(neuron)
	
	# Add new term
	SearchEngine.add_term(text)
	
	# Add suggestion to selected neuron
	SearchEngine.add_suggestion(selected_neuron.get_label(), text)

func create_connection_with(neuron):
	var connexion = connexion_scene.instance()
	connexion.set_first_neuron(neuron)
	connexion.set_second_neuron(selected_neuron)
	add_child(connexion)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_WHEEL_UP and event.pressed:
			$Background/Camera2D.zoom += ZOOM_SENSITIVITY
		elif event.button_index == BUTTON_WHEEL_DOWN and event.pressed:
			$Background/Camera2D.zoom -= ZOOM_SENSITIVITY 

extends Node2D

var neuron_scene = load("res://Neuron.tscn")
var connexion_scene = load("res://Connexion.tscn")
var selected_neuron

func _ready():
	selected_neuron = $MainNeuron
	$MainNeuron.connect("is_selected", self, "neuron_is_selected")

func neuron_is_selected(neuron):
	selected_neuron = neuron
	$SearchBar.show()
	put_focus_on_line_edit()

func put_focus_on_line_edit():
	$SearchBar/LineEdit.clear()
	$SearchBar/LineEdit.grab_focus()
	var suggestions = SearchEngine.get_suggestions(selected_neuron.get_label())
	$SearchBar.set_suggestions(suggestions)

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

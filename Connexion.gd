extends Node2D

var neurons = [Vector2.ZERO, Vector2.ZERO]

func _ready():
	z_index = -1

func set_first_neuron(neuron):
	neurons[0] = neuron
	$Line2D.set_point_position(0, neuron.position)
	neuron.connect("is_moving", self, "set_first_neuron_position")

func set_second_neuron(neuron):
	neurons[1] = neuron
	$Line2D.set_point_position(1, neuron.position)
	neuron.connect("is_moving", self, "set_second_neuron_position")

func set_first_neuron_position(position):
	$Line2D.set_point_position(0, position)

func set_second_neuron_position(position):
	$Line2D.set_point_position(1, position)
